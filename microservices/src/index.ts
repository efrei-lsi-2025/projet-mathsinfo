import { getMetroColor } from '../../applications/data/utils';
import { createMapCanvas } from './canvas';
import { intergares, stations } from './data';
import { dijkstra } from './dijkstra';
import { kruskal } from './kruskal';
import { readAndParseData } from './parser';

const express = require('express');
const app = express();
const port = 3000;

async function main() {
  await readAndParseData();

  // express listen
  const router = express.Router();

  router.get('/', (req: any, res: any) => {
    res.json({
      message: "Bienvenue sur l'API RATP Itinéraires.",
      routes: ['/stations', '/canvas', '/path/:s1/:s2', '/kruskal']
    });
  });

  router.get('/canvas', async (req: any, res: any) => {
    res.set('Content-Type', 'image/png');
    let canvas = await createMapCanvas(intergares);
    canvas.createPNGStream().pipe(res);
  });

  router.get('/kruskal', async (req: any, res: any) => {
    res.set('Content-Type', 'image/png');
    let inters = kruskal();
    let canvas = await createMapCanvas(inters);
    canvas.createPNGStream().pipe(res);
  });

  router.get('/stations', (req: any, res: any) => {
    // stations without adjacentInterstations and adjacentStations
    let stns = stations.map(s => {
      return {
        num: s.num,
        nom: s.nom,
        ligne: s.ligne,
        terminus: s.terminus,
        branchement: s.branchement,
        posX: s.posX,
        posY: s.posY,
        adjacentStations: s.adjacentStations.map(s => {
          return {
            num: s.station.num,
            nom: s.station.nom,
            ligne: s.station.ligne,
            branchement: s.station.branchement || 0,
            correspondance: s.time
          };
        })
      };
    });
    res.send(stns);
  });

  // router to get path from a station ID to another
  router.get('/path/:station_1/:station_2', async (req: any, res: any) => {
    if (!stations.find(s => s.num == req.params.station_1)) {
      res.status(404).send({ message: "La station de départ n'existe pas." });
      return;
    }
    if (!stations.find(s => s.num == req.params.station_2)) {
      res.status(404).send({ message: "La station d'arrivée n'existe pas." });
      return;
    }
    if (req.params.station_1 == req.params.station_2) {
      res.status(400).send({
        message: "La station de départ et d'arrivée sont identiques."
      });
      return;
    }

    let station_1 = stations.find(
      s => s.num === parseInt(req.params.station_1)
    );
    let station_2 = stations.find(
      s => s.num === parseInt(req.params.station_2)
    );

    let { path, time } = dijkstra(station_1, station_2);

    let pathByLine = [];
    for (let i in path) {
      let station = path[i];
      let tr = pathByLine[station.ligne] || [];
      tr.push(station);
    }

    res.status(200).send({
      path: path.map(s => {
        return {
          num: s.num,
          nom: s.nom,
          ligne: s.ligne,
          couleurLigne: getMetroColor(s.ligne),
          terminus: s.terminus,
          branchement: s.branchement,
          posX: s.posX,
          posY: s.posY,
          adjacentStations: s.adjacentStations.map(s => {
            return {
              num: s.station.num,
              nom: s.station.nom,
              ligne: s.station.ligne,
              correspondance: s.time
            };
          })
        };
      }),
      time
    });
  });

  app.use('/api', router);

  app.listen(port, () => {
    console.log(`Express: Le serveur est prêt: http://localhost:${port}`);
  });
}

main();
