import fs from "fs";
import { AdjacentStation, Gare, Intergare, Station } from "./types";
import { getMetroColor, KruskalSet } from "./utils";

import canvasLibrary from "canvas";

const express = require("express");
const app = express();
const port = 3000;

const gares: Gare[] = [];
const intergares: Intergare[] = [];
const stations: Station[] = [];

export { stations };

async function readAndParseData() {

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
        branchement: parseInt(lineSplit[2].split(" ").filter(n => n)[1]),
        adjacentStations: [],
      });

      // Gares uniques pour l'ACPM
      if (!gares.find(g => g.nom === lineSplit[0].slice(6).trim())) {
        gares.push({
          nom: lineSplit[0].slice(6).trim(),
          lignes: [lineSplit[1].trim()],
        });
      } else {
        gares.find(g => g.nom === lineSplit[0].slice(6).trim()).lignes.push(lineSplit[1].trim());
      }
    } else {
      let areteDetails = linesArray[i].slice(2).split(" ")

      let station_1 = stations.find(
        (s) => s.num === parseInt(areteDetails[0])
      );

      let station_2 = stations.find(
        (s) => s.num === parseInt(areteDetails[1])
      );

      // intergares et ajout de la ligne
      if (!intergares.find(g => g.gare_1?.nom === station_1?.nom && g.gare_2?.nom === station_2?.nom && g.ligne === station_1?.ligne)) {
        intergares.push({
          gare_1: gares.find(g => g.nom === station_1?.nom),
          gare_2: gares.find(g => g.nom === station_2?.nom),
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
        console.log(
          `Parsing: Station ${areteDetails[0]} not found.`
        );
      }

      if (station_2) {
        station_2.adjacentStations.push({
          time: parseInt(areteDetails[2]),
          station: station_1,
        });
      } else {
        console.log(
          `Parsing: Station ${areteDetails[1]} not found.`
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

async function createMapCanvas(inters: Intergare[]) {
  const canvas = canvasLibrary.createCanvas(987, 952);
  const canvasCtx = canvas.getContext("2d");

  const image = await canvasLibrary.loadImage("./docs/metrof_r.png");
  canvasCtx.globalAlpha = 0.1;
  canvasCtx.drawImage(image, 0, 0, 987, 952);
  canvasCtx.globalAlpha = 1;

  console.log(`Canvas: Drawing ${inters.length} intergares and ${stations.length} stations.`);

  // draw line between stations
  for (let i in inters) {
    canvasCtx.beginPath();
    if (inters[i].gare_1 && inters[i].gare_2) {
      canvasCtx.moveTo(
        inters[i].gare_1.posX,
        inters[i].gare_1.posY
      );
      canvasCtx.lineTo(
        inters[i].gare_2.posX,
        inters[i].gare_2.posY
      );
      canvasCtx.strokeStyle = getMetroColor(inters[i].ligne);
      canvasCtx.stroke();
    }
  }

  let drawnGares: Gare[] = [];
  for (let i in gares) {
    if (gares[i].lignes && gares[i].lignes.length > 1) {
      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 4, 0, 2 * Math.PI);
      canvasCtx.fillStyle = "black";
      canvasCtx.fill();

      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = "white";
      canvasCtx.fill();
    } else {
      drawnGares.push(gares[i]);
      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = getMetroColor(gares[i].lignes[0]);
      canvasCtx.fill();
    }
  }

  return canvas;
}

const dijkstra = (start: Station, end: Station) => {
  console.log(`Dijkstra: Starting...`);
  let dt = new Date().getTime();

  let visited: Station[] = [];
  let unvisited: Station[] = [start];
  let PCC: AdjacentStation[] = [];

  for (let i in stations) {
    if (stations[i] == start) {
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

  console.log(`Dijkstra: Done in ${new Date().getTime() - dt}ms.`);
  console.log(`Dijkstra: Path from ${start.nom} to ${end.nom}:\n${path.map((s) => s.nom).join(" -> ")}`);

  return {
    path,
    time: PCC[end.num].time
  };
};

const kruskal = () => {
  console.log(`Kruskal: Starting...`);
  let dt = new Date().getTime();

  const garesCopy = [...gares.map((g) => ({ nom: g.nom, lignes: g.lignes, posX: g.posX, posY: g.posY }))];
  const intergaresCopy = [...intergares.map((i) => ({ gare_1: garesCopy.find((g) => g.nom === i.gare_1.nom), gare_2: garesCopy.find((g) => g.nom === i.gare_2.nom), ligne: i.ligne, time: i.time }))];

  const arbre: Intergare[] = [];
  const ACPM = new KruskalSet();

  intergaresCopy.sort((a, b) => a.time - b.time);

  for (let i in intergaresCopy) {
    ACPM.makeSet(intergaresCopy[i].gare_1);
    ACPM.makeSet(intergaresCopy[i].gare_2);
  }

  for (let i in intergaresCopy) {
    if (ACPM.find(intergaresCopy[i].gare_1) !== ACPM.find(intergaresCopy[i].gare_2)) {
      arbre.push(intergaresCopy[i]);
      ACPM.union(ACPM.find(intergaresCopy[i].gare_1), ACPM.find(intergaresCopy[i].gare_2));
    }
  }

  console.log(`Kruskal: Done in ${new Date().getTime() - dt}ms.`);
  console.log(`Kruskal: ${arbre.length} intergares in the ACPM with a ${arbre.reduce((a, b) => a + b.time, 0)}s total time.`);

  return arbre;
}

async function main() {
  await readAndParseData();

  // express listen
  const router = express.Router();

  router.get("/", (req: any, res: any) => {
    res.json({ message: "Bienvenue sur l'API RATP Itinéraires.", routes: ["/stations", "/canvas", "/path/:s1/:s2", "/kruskal"] });
  });

  router.get("/canvas", async (req: any, res: any) => {
    res.set("Content-Type", "image/png");
    let canvas = await createMapCanvas(intergares);
    canvas.createPNGStream().pipe(res);
  });

  router.get("/kruskal", async (req: any, res: any) => {
    res.set("Content-Type", "image/png");
    let inters = kruskal();
    let canvas = await createMapCanvas(inters)
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
        posX: s.posX,
        posY: s.posY,
        adjacentStations: s.adjacentStations.map(
          (s) => { return { num: s.station.num, nom: s.station.nom, ligne: s.station.ligne, branchement: s.station.branchement || 0, correspondance: s.time } }
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
          posX: s.posX,
          posY: s.posY,
          adjacentStations: s.adjacentStations.map(
            (s) => { return { num: s.station.num, nom: s.station.nom, ligne: s.station.ligne, correspondance: s.time } }
          ),
        };
      }),
      time
    });
  });

  app.use("/", express.static("src/client"));

  app.use("/api", router);

  app.listen(port, () => {
    console.log(`Express: Le serveur est prêt: http://localhost:${port}`);
  });
}

main();
