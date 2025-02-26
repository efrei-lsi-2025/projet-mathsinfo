import fs from 'fs';
import { AdjacentStation, db, Gare, Intergare, Station } from '..';
import { lignes } from './data/lignes';

export async function readAndParseData() {
  console.log('Parsing: Reading metro.txt file.');

  await db.ligne.deleteMany({});
  await db.gare.deleteMany({});

  let fileLines = await fs.readFileSync('src/scripts/data/metro.txt', 'utf8');
  let linesArray = fileLines.split('\n').slice(15);

  const stations: Station[] = [];
  const gares: Gare[] = [];
  const intergares: Intergare[] = [];
  const adjacentStations: AdjacentStation[] = [];

  const lignesGares = new Map<string, string[]>();

  for (let i in linesArray) {
    let lineSplit = linesArray[i].split(';');

    if (lineSplit[0].charAt(0) === 'V') {
      const nomGare = lineSplit[0].slice(6).trim();
      const nomLigne = lineSplit[1].trim();

      stations.push({
        num: parseInt(lineSplit[0].slice(2).slice(0, 4)),
        nom: nomGare,
        ligneNom: nomLigne,
        terminus: lineSplit[2].split(' ')[0] === 'True',
        branchement: parseInt(lineSplit[2].split(' ').filter(n => n)[1]),
        posX: 0,
        posY: 0
      });

      if (!lignesGares.has(nomLigne)) {
        lignesGares.set(nomLigne, []);
      }

      lignesGares.get(nomLigne)?.push(nomGare);

      // Gares uniques pour l'ACPM
      if (!gares.find(g => g.nom === nomGare)) {
        gares.push({
          nom: nomGare,
          posX: 0,
          posY: 0
        });
      }
    } else {
      let areteDetails = linesArray[i].slice(2).split(' ');

      let station_1 = stations.find(s => s.num === parseInt(areteDetails[0]))!;
      let station_2 = stations.find(s => s.num === parseInt(areteDetails[1]))!;

      // intergares et ajout de la ligne
      if (
        !intergares.find(
          g =>
            ((g.gare1Nom === station_1?.nom && g.gare2Nom === station_2?.nom) ||
              (g.gare1Nom === station_2?.nom &&
                g.gare2Nom === station_1?.nom)) &&
            g.ligneNom === station_1?.ligneNom
        )
      ) {
        intergares.push({
          gare1Nom: station_1.nom,
          gare2Nom: station_2.nom,
          time: parseInt(areteDetails[2]),
          ligneNom: station_1?.ligneNom
        });
      }

      if (
        !adjacentStations.find(
          adj =>
            (adj.station1Num === station_1?.num &&
              adj.station2Num === station_2?.num) ||
            (adj.station1Num === station_2?.num &&
              adj.station2Num === station_1?.num)
        )
      ) {
        adjacentStations.push({
          station1Num: station_1.num,
          station2Num: station_2.num,
          time: parseInt(areteDetails[2])
        });
      }
    }
  }

  let positions = await fs.readFileSync(
    'src/scripts/data/pospoints.txt',
    'utf8'
  );
  let positionsArray = positions.split('\n');
  for (let i in positionsArray) {
    let lineSplit = positionsArray[i].split(';');
    let stationsFound = stations.filter(
      s => s.nom === lineSplit[2].replace(/@/g, ' ').trim()
    );
    if (stationsFound.length > 0) {
      for (let j in stationsFound) {
        stationsFound[j].posX = parseInt(lineSplit[0]);
        stationsFound[j].posY = parseInt(lineSplit[1]);
      }
    }
    let gare = gares.find(
      g => g.nom === lineSplit[2].replace(/@/g, ' ').trim()
    );
    if (gare) {
      gare.posX = parseInt(lineSplit[0]);
      gare.posY = parseInt(lineSplit[1]);
    }
  }

  console.log('Parsing: Done, inserting data.');

  await db.$transaction(async tx => {
    await tx.ligne.createMany({
      data: lignes
    });

    await tx.gare.createMany({
      data: gares
    });

    await tx.intergare.createMany({
      data: intergares
    });

    await tx.station.createMany({
      data: stations
    });

    await tx.adjacentStation.createMany({
      data: adjacentStations
    });

    for (let ligne of lignes) {
      await tx.ligne.update({
        where: {
          nom: ligne.nom
        },
        data: {
          gares: {
            connect:
              lignesGares.get(ligne.nom)?.map(gare => ({
                nom: gare
              })) || []
          }
        }
      });
    }
  });

  console.log('Parsing: Done inserting data.');
}

readAndParseData();
