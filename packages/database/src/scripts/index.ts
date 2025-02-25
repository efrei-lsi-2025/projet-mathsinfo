import { InferInsertModel } from 'drizzle-orm';
import fs from 'fs';
import { db } from '../index';
import {
  adjacentStationTable,
  garesToLignesTable,
  gareTable,
  intergareTable,
  ligneTable,
  stationTable
} from '../schema';

type LigneTable = InferInsertModel<typeof ligneTable>;
type StationTable = InferInsertModel<typeof stationTable>;
type GareTable = InferInsertModel<typeof gareTable>;
type IntergareTable = InferInsertModel<typeof intergareTable>;
type AdjacentStationTable = InferInsertModel<typeof adjacentStationTable>;
type GaresToLignesTable = InferInsertModel<typeof garesToLignesTable>;

export async function readAndParseData() {
  console.log('Parsing: Reading metro.txt file.');
  let fileLines = await fs.readFileSync('./docs/metro.txt', 'utf8');
  let linesArray = fileLines.split('\n').slice(15);

  // Insert lines
  await db
    .insert(ligneTable)
    .values([
      { nom: '1', couleur: '#ffcd00' },
      { nom: '2', couleur: '#003df5' },
      { nom: '3', couleur: '#827a04' },
      { nom: '3bis', couleur: '#71c5e8' },
      { nom: '4', couleur: '#c800a1' },
      { nom: '5', couleur: '#ff7f32' },
      { nom: '6', couleur: '#71cc98' },
      { nom: '7', couleur: '#f59bbb' },
      { nom: '7bis', couleur: '#71cc98' },
      { nom: '8', couleur: '#dd9cdf' },
      { nom: '9', couleur: '#b5bd00' },
      { nom: '10', couleur: '#c69214' },
      { nom: '11', couleur: '#6e4c1e' },
      { nom: '12', couleur: '#007a53' },
      { nom: '13', couleur: '#71c5e8' },
      { nom: '14', couleur: '#5f259f' },
      { nom: '15', couleur: '#a50034' },
      { nom: '16', couleur: '#f59bbb' },
      { nom: '17', couleur: '#b5bd00' },
      { nom: '18', couleur: '#00ab8e' }
    ])
    .returning();

  const stations: StationTable[] = [];
  const gares: GareTable[] = [];
  const intergares: IntergareTable[] = [];
  const garesToLignes: GaresToLignesTable[] = [];
  const adjacentStations: AdjacentStationTable[] = [];

  for (let i in linesArray) {
    let lineSplit = linesArray[i].split(';');

    if (lineSplit[0].charAt(0) === 'V') {
      const nomGare = lineSplit[0].slice(6).trim();
      const nomLigne = lineSplit[1].trim();

      stations.push({
        num: parseInt(lineSplit[0].slice(2).slice(0, 4)),
        nom: nomGare,
        nomLigne: nomLigne,
        isTerminus: lineSplit[2].split(' ')[0] === 'True',
        branchement: parseInt(lineSplit[2].split(' ').filter(n => n)[1])
      });

      // Gares uniques pour l'ACPM
      if (!gares.find(g => g.nom === nomGare)) {
        gares.push({
          nom: nomGare
        });
      }

      garesToLignes.push({
        nomGare: nomGare,
        nomLigne: nomLigne
      });
    } else {
      let areteDetails = linesArray[i].slice(2).split(' ');

      let station_1 = stations.find(s => s.num === parseInt(areteDetails[0]))!;
      let station_2 = stations.find(s => s.num === parseInt(areteDetails[1]))!;

      // intergares et ajout de la ligne
      if (
        !intergares.find(
          g =>
            ((g.nomGare1 === station_1?.nom && g.nomGare2 === station_2?.nom) ||
              (g.nomGare1 === station_2?.nom &&
                g.nomGare2 === station_1?.nom)) &&
            g.nomLigne === station_1?.nomLigne
        )
      ) {
        intergares.push({
          nomGare1: station_1.nom,
          nomGare2: station_2.nom,
          timeSeconds: parseInt(areteDetails[2]),
          nomLigne: station_1?.nomLigne
        });
      }

      if (
        !adjacentStations.find(
          adj =>
            (adj.numStation1 === station_1?.num &&
              adj.numStation2 === station_2?.num) ||
            (adj.numStation1 === station_2?.num &&
              adj.numStation2 === station_1?.num)
        )
      ) {
        adjacentStations.push({
          numStation1: station_1.num,
          numStation2: station_2.num,
          timeSeconds: parseInt(areteDetails[2])
        });
      }
    }
  }

  let positions = await fs.readFileSync('./docs/pospoints.txt', 'utf8');
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

  console.log('Parsing: Done.');

  db.insert(gareTable).values(gares);
  db.insert(garesToLignesTable).values(garesToLignes);
  db.insert(intergareTable).values(intergares);
  db.insert(stationTable).values(stations);
  db.insert(adjacentStationTable).values(adjacentStations);
}
