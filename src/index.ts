import fs from 'fs';
import { Interstation, Station } from './types';

import canvasLibrary from 'canvas';
const canvas = canvasLibrary.createCanvas(987, 952);
const canvasCtx = canvas.getContext('2d');

const express = require('express');
const app = express();
const port = 3000;

const stations: Station[] = [];
const interstations: Interstation[] = [];

async function readAndParseData() {
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

  // example data from pospoints: 744;811;Bibliothèque@François@Mitterand
  let positions = await fs.readFileSync('./docs/pospoints.txt', 'utf8');
  let positionsArray = positions.split('\n');
  for(let i in positionsArray) {
    let lineSplit = positionsArray[i].split(";");
    let station = stations.find((s) => s.nom === lineSplit[2].replace(/@/g, " ").trim());
    if(station) {
      station.lat = parseInt(lineSplit[0]);
      station.lng = parseInt(lineSplit[1]);
    }
  }
}

async function startCanvasAndServer() {
  const image = await canvasLibrary.loadImage('./docs/metrof_r.png');
  canvasCtx.drawImage(image, 0, 0, 987, 952);

  // place point for each station on the map
  for(let i in stations) {
    canvasCtx.beginPath();
    canvasCtx.arc(stations[i].lat, stations[i].lng, 3, 0, 2 * Math.PI);
    canvasCtx.fillStyle = "red";
    canvasCtx.fill();
  }
}

async function main() {

  await readAndParseData();
  console.log("Done.")
  
  let station_1 = stations.find((s) => s.nom === "Esplanade de la Défense")!;
  let station_2 = stations.find((s) => s.nom === "Porte de la Villette")!;

  startCanvasAndServer();

  // express listen
  const router = express.Router();

  router.get('/', (req: any, res: any) => {
    res.send('Hello World!');
  });

  router.get('/canvas', (req: any, res: any) => {
    res.set('Content-Type', 'image/png');
    canvas.createPNGStream().pipe(res);
  });

  router.get('/stations', (req: any, res: any) => {
    res.send(stations);
  });

  router.get('/interstations', (req: any, res: any) => {
    res.send(interstations);
  });

  app.use('/', router);

  app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  });

}



main();