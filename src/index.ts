import fs from "fs";
import { AdjacentStation, Interstation, Station } from "./types";
import { getMetroColor } from "./utils";

import canvasLibrary from "canvas";
const canvas = canvasLibrary.createCanvas(987, 952);
const canvasCtx = canvas.getContext("2d");

const express = require("express");
const app = express();
const port = 3000;

const stations: Station[] = [];
const interstations: Interstation[] = [];

export { stations, interstations };

async function readAndParseData() {

  console.log("Reading metro.txt file.");
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
        branchement: parseInt(lineSplit[2].split(" ")[1]),
        adjacentStations: [],
      });
    } else {
      let areteDetails = linesArray[i].slice(2).split(" ")

      let station_1 = stations.find(
        (s) => s.num === parseInt(areteDetails[0])
      );

      let station_2 = stations.find(
        (s) => s.num === parseInt(areteDetails[1])
      );

      interstations.push({
        station_1,
        station_2,
        time: parseInt(areteDetails[2]),
      });

      if (station_1) {
        station_1.adjacentStations.push({
          time: parseInt(areteDetails[2]),
          station: station_2,
        });
      } else {
        console.log(
          `Station ${areteDetails[0]} not found.`
        );
      }

      if (station_2) {
        station_2.adjacentStations.push({
          time: parseInt(areteDetails[2]),
          station: station_1,
        });
      } else {
        console.log(
          `Station ${areteDetails[1]} not found.`
        );
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
    for (let j in stationsFound) {
      stationsFound[j].lat = parseInt(lineSplit[0]);
      stationsFound[j].lng = parseInt(lineSplit[1]);
    }
  }
}

async function startCanvasAndServer() {
  const image = await canvasLibrary.loadImage("./docs/metrof_r.png");
  canvasCtx.globalAlpha = 0.3;
  canvasCtx.drawImage(image, 0, 0, 987, 952);
  canvasCtx.globalAlpha = 1;

  // draw line between stations
  for (let i in interstations) {
    canvasCtx.beginPath();
    if (interstations[i].station_1 && interstations[i].station_2) {
      canvasCtx.moveTo(
        interstations[i].station_1.lat,
        interstations[i].station_1.lng
      );
      canvasCtx.lineTo(
        interstations[i].station_2.lat,
        interstations[i].station_2.lng
      );
      canvasCtx.strokeStyle = getMetroColor(interstations[i].station_1?.ligne);
      canvasCtx.stroke();
    }
  }

  // place point for each station on the map
  let drawnStations: Station[] = [];
  for (let i in stations) {
    if (drawnStations.find((s) => s.nom === stations[i].nom)) {
      canvasCtx.beginPath();
      canvasCtx.arc(stations[i].lat, stations[i].lng, 4, 0, 2 * Math.PI);
      canvasCtx.fillStyle = "black";
      canvasCtx.fill();

      canvasCtx.beginPath();
      canvasCtx.arc(stations[i].lat, stations[i].lng, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = "white";
      canvasCtx.fill();
    } else {
      drawnStations.push(stations[i]);
      canvasCtx.beginPath();
      canvasCtx.arc(stations[i].lat, stations[i].lng, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = getMetroColor(stations[i].ligne);
      canvasCtx.fill();
    }
  }
}

const dijkstra = (start: Station, end: Station) => {
  let visited: Station[] = [];
  let unvisited: Station[] = [start];
  let PCC: AdjacentStation[] = [];

  for(let i in stations) {
    if(stations[i] == start) {
      PCC[stations[i].num] = { station: start, time: 0 };
    } else {
      PCC[stations[i].num] = { station: null, time: Infinity };
    }
  }

  let stationActuelle: Station;
  while ((stationActuelle = unvisited.sort((a, b) => PCC[a.num].time - PCC[b.num].time).shift())) {

    // On récupère les stations adjacentes qui n'ont pas encore été visitées
    let stationsAdjacentes = stations
      .find((station) => station.num === stationActuelle.num)
      .adjacentStations
      .filter(
        (n) => visited.filter((v) => v.num === n.station.num).length === 0
      );

    // On ajoute les voisins dans la liste des stations pas encore visitées
    unvisited.push(...stationsAdjacentes.map((n) => n.station));

    let timeToStation = PCC[stationActuelle.num].time;

    for (let st of stationsAdjacentes) {
      let timeVoisin = PCC[st.station.num] && PCC[st.station.num].time;
      let nouveauCout = timeToStation + st.time;
      if (
        timeVoisin === undefined ||
        nouveauCout < timeVoisin
      ) {
        PCC[st.station.num] = { station: stationActuelle, time: nouveauCout };
      }
    }

    visited.push(stationActuelle);
  }

  // On trace le chemin
  let path = [];
  let prochaineStation = end;
  while (true) {
    path.unshift(prochaineStation);
    // Condition d'arrêt: si on est arrivé à la station de départ
    if (prochaineStation.num === start.num) break;
    prochaineStation = PCC[prochaineStation.num].station;
  }

  return {
    path,
    time: PCC[end.num].time
  };
};

const find = (parent: Interstation[], station:Interstation) : number => {
  const i : number = parent.indexOf(station);
  if(parent[i] == station) return i;
  return find(parent, parent[i]);
}

const union = (parent: Interstation[], x:number, y:number) => {
  parent[x] = parent[y];
}

const Kruskal = () => {
  const ACPM: Interstation[] = [];
  let aretesSorted: Interstation[] = interstations.sort((a, b) => a.time - b.time);
  let subsets: Station[];
  for(let aretes in aretesSorted){
    
  }
}

async function main() {
  await readAndParseData();
  console.log("Done.");

  startCanvasAndServer();

  // express listen
  const router = express.Router();

  router.get("/", (req: any, res: any) => {
    res.send("Hello World!");
  });

  router.get("/canvas", (req: any, res: any) => {
    res.set("Content-Type", "image/png");
    canvas.createPNGStream().pipe(res);
  });

  router.get("/stations", (req: any, res: any) => {
    // stations without adjacentInterstations and adjacentStations
    let stns = stations.map((s) => {
      return {
        num: s.num,
        nom: s.nom,
        ligne: s.ligne,
        terminus: s.terminus,
        branchement: s.branchement,
        lat: s.lat,
        lng: s.lng,
        adjacentStations: s.adjacentStations.map(
          (s) => { return { num: s.station.num, nom: s.station.nom, ligne: s.station.ligne, correspondance: s.time } }
        ),
      };
    });
    res.send(stns);
  });

  // router to get path from a station ID to another
  router.get("/path/:station_1/:station_2", async (req: any, res: any) => {
    if(!stations.find(s => s.num == req.params.station_1)) {
      res.status(404).send({ message: "La station de départ n'existe pas." });
      return;
    }
    if(!stations.find(s => s.num == req.params.station_2)) {
      res.status(404).send({ message: "La station d'arrivée n'existe pas." });
      return;
    }
    if(req.params.station_1 == req.params.station_2) {
      res.status(400).send({ message: "La station de départ et d'arrivée sont identiques." });
      return;
    }

    let station_1 = stations.find(
      (s) => s.num === parseInt(req.params.station_1)
    );
    let station_2 = stations.find(
      (s) => s.num === parseInt(req.params.station_2)
    );

    let { path, time } = await dijkstra(station_1, station_2);

    let pathByLine = [];
    for (let i in path) {
      let station = path[i];
      let tr = pathByLine[station.ligne] || [];
      tr.push(station);
    }

    res.status(200).send({
      path: path.map((s) => {
        return {
          num: s.num,
          nom: s.nom,
          ligne: s.ligne,
          couleurLigne: getMetroColor(s.ligne),
          terminus: s.terminus,
          branchement: s.branchement,
          lat: s.lat,
          lng: s.lng,
          adjacentStations: s.adjacentStations.map(
            (s) => { return { num: s.station.num, nom: s.station.nom, ligne: s.station.ligne, correspondance: s.time } }
          ),
        };
      }),
      time
    });
  });

  router.get("/interstations", (req: any, res: any) => {
    res.send(interstations);
  });

  app.use("/", express.static("src/client"));

  app.use("/api", router);

  app.listen(port, () => {
    console.log(`RATP Itinéraires @ http://localhost:${port}`);
  });
}

main();
