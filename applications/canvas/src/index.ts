import { Gare, Intergare } from '@metro-boulot-dodo/proto';
import { getMetroColor } from '@metro-boulot-dodo/utils';
import canvasLibrary from 'canvas';

export async function createMapCanvas(inters: Intergare[]) {
  const canvas = canvasLibrary.createCanvas(987, 952);
  const canvasCtx = canvas.getContext('2d');

  const image = await canvasLibrary.loadImage('./docs/metrof_r.png');
  canvasCtx.globalAlpha = 0.1;
  canvasCtx.drawImage(image, 0, 0, 987, 952);
  canvasCtx.globalAlpha = 1;

  console.log(
    `Canvas: Drawing ${inters.length} intergares and ${stations.length} stations.`
  );

  // draw line between stations
  for (let i in inters) {
    canvasCtx.beginPath();
    if (inters[i].gare_1 && inters[i].gare_2) {
      canvasCtx.moveTo(inters[i].gare_1.posX, inters[i].gare_1.posY);
      canvasCtx.lineTo(inters[i].gare_2.posX, inters[i].gare_2.posY);
      canvasCtx.strokeStyle = getMetroColor(inters[i].ligne);
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
      canvasCtx.fillStyle = getMetroColor(gares[i].lignes[0]);
      canvasCtx.fill();
    }
  }

  return canvas;
}
