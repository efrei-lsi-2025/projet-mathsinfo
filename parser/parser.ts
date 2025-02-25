import fs from "fs";
import { gares, intergares, stations } from "./data";

export async function readAndParseData() {
  console.log("Parsing: Reading metro.txt file.");
  let lines = await fs.readFileSync("./docs/metro.txt", "utf8");
  let linesArray = lines.split("\n").slice(15);
  for (let i in linesArray) {
    let lineSplit = linesArray[i].split(";");
    if (lineSplit[0].charAt(0) === "V") {
      stations.push({
        num: parseInt(lineSplit[0].slice(2).slice(0, 4)),
        nom: lineSplit[0].slice(6).trim(),
        ligne: lineSplit[1].trim(),
        terminus: lineSplit[2].split(" ")[0] === "True",
        branchement: parseInt(lineSplit[2].split(" ").filter((n) => n)[1]),
        adjacentStations: [],
      });

      // Gares uniques pour l'ACPM
      if (!gares.find((g) => g.nom === lineSplit[0].slice(6).trim())) {
        gares.push({
          nom: lineSplit[0].slice(6).trim(),
          lignes: [lineSplit[1].trim()],
        });
      } else {
        gares
          .find((g) => g.nom === lineSplit[0].slice(6).trim())
          .lignes.push(lineSplit[1].trim());
      }
    } else {
      let areteDetails = linesArray[i].slice(2).split(" ");

      let station_1 = stations.find((s) => s.num === parseInt(areteDetails[0]));

      let station_2 = stations.find((s) => s.num === parseInt(areteDetails[1]));

      // intergares et ajout de la ligne
      if (
        !intergares.find(
          (g) =>
            g.gare_1?.nom === station_1?.nom &&
            g.gare_2?.nom === station_2?.nom &&
            g.ligne === station_1?.ligne
        )
      ) {
        intergares.push({
          gare_1: gares.find((g) => g.nom === station_1?.nom),
          gare_2: gares.find((g) => g.nom === station_2?.nom),
          time: parseInt(areteDetails[2]),
          ligne: station_1?.ligne,
        });
      }

      if (station_1) {
        station_1.adjacentStations.push({
          time: parseInt(areteDetails[2]),
          station: station_2,
        });
      } else {
        console.log(`Parsing: Station ${areteDetails[0]} not found.`);
      }

      if (station_2) {
        station_2.adjacentStations.push({
          time: parseInt(areteDetails[2]),
          station: station_1,
        });
      } else {
        console.log(`Parsing: Station ${areteDetails[1]} not found.`);
      }
    }
  }

  let positions = await fs.readFileSync("./docs/pospoints.txt", "utf8");
  let positionsArray = positions.split("\n");
  for (let i in positionsArray) {
    let lineSplit = positionsArray[i].split(";");
    let stationsFound = stations.filter(
      (s) => s.nom === lineSplit[2].replace(/@/g, " ").trim()
    );
    if (stationsFound.length > 0) {
      for (let j in stationsFound) {
        stationsFound[j].posX = parseInt(lineSplit[0]);
        stationsFound[j].posY = parseInt(lineSplit[1]);
      }
    }
    let gare = gares.find(
      (g) => g.nom === lineSplit[2].replace(/@/g, " ").trim()
    );
    if (gare) {
      gare.posX = parseInt(lineSplit[0]);
      gare.posY = parseInt(lineSplit[1]);
    }
  }

  console.log("Parsing: Done.");
}
