import { clients, Empty, Gare, Intergare } from '@metro-boulot-dodo/proto';
import canvasLibrary from 'canvas';
import path from 'path';

export async function createMapCanvas(inters: Intergare[]) {
  const canvas = canvasLibrary.createCanvas(987, 952);
  const canvasCtx = canvas.getContext('2d');

  const stations = (await clients.dataService.getStations(Empty).response)
    .stations;
  const gares = (await clients.dataService.getGares(Empty).response).gares;

  const image = await canvasLibrary.loadImage(path.join(__dirname, 'map.png'));
  canvasCtx.globalAlpha = 0.1;
  canvasCtx.drawImage(image, 0, 0, 987, 952);
  canvasCtx.globalAlpha = 1;

  console.log(
    `Canvas: Drawing ${inters.length} intergares and ${stations.length} stations.`
  );

  // draw line between stations
  for (let i in inters) {
    canvasCtx.beginPath();
    if (inters[i].gare1 && inters[i].gare2) {
      canvasCtx.moveTo(inters[i].gare1.posX, inters[i].gare1.posY);
      canvasCtx.lineTo(inters[i].gare2.posX, inters[i].gare2.posY);
      canvasCtx.strokeStyle = inters[i].ligne?.couleur || 'black';
      canvasCtx.stroke();
    }
  }

  let drawnGares: Gare[] = [];
  for (let i in gares) {
    if (gares[i].lignes && gares[i].lignes.length > 1) {
      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 4, 0, 2 * Math.PI);
      canvasCtx.fillStyle = 'black';
      canvasCtx.fill();

      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = 'white';
      canvasCtx.fill();
    } else {
      drawnGares.push(gares[i]);
      canvasCtx.beginPath();
      canvasCtx.arc(gares[i].posX, gares[i].posY, 3, 0, 2 * Math.PI);
      canvasCtx.fillStyle = gares[i].lignes[0].couleur;
      canvasCtx.fill();
    }
  }

  return canvas;
}
