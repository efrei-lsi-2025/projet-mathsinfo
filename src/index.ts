import fs from 'fs';
import { Interstation, Station } from './types';

const stations: Station[] = [];
const interstations: Interstation[] = [];

async function readAndParseMetroTxt() {
  console.log("Reading metro.txt file.");
  let lines = await fs.readFileSync('./docs/metro.txt', 'utf8');
  let linesArray = lines.split('\n').slice(15);
  for(let i in linesArray) {
    let lineSplit = linesArray[i].split(";");
    if(lineSplit[0].charAt(0) === "V") {
      stations.push({
        num: parseInt(lineSplit[0].slice(2).slice(0, 4)),
        nom: lineSplit[0].slice(6).trim(),
        ligne: parseInt(lineSplit[1].trim()),
        terminus: lineSplit[2].split(" ")[0] === "True",
        branchement: parseInt(lineSplit[2].split(" ")[1])
      });
    } else {
      interstations.push({
        station_1: stations.find((s) => s.num === parseInt(linesArray[i].slice(2).split(" ")[0])),
        station_2: stations.find((s) => s.num === parseInt(linesArray[i].slice(2).split(" ")[1])),
        temps: parseInt(linesArray[i].split(" ")[2])
      });
    }
  }

  console.log(stations);
  console.log(interstations);
}

async function main() {

  let readMetroTxt = await readAndParseMetroTxt();
  console.log("Done.")

}

main();