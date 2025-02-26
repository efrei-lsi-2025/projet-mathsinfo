import { clients, Empty, Intergare } from '@metro-boulot-dodo/proto';
import { KruskalSet } from './utils';

export const generateMST = async () => {
  console.log(`Kruskal: Starting...`);
  let dt = new Date().getTime();

  const gares = (await clients.dataService.getGares(Empty).response).gares;
  const intergares = (await clients.dataService.getIntergares(Empty).response)
    .intergares;

  console.log(
    `Kruskal: ${gares.length} gares and ${
      intergares.length
    } intergares, first: ${JSON.stringify(gares[0])}.`
  );

  const arbre: Intergare[] = [];
  const ACPM = new KruskalSet<string>(); // nom de la gare

  intergares.sort((a, b) => a.time - b.time);

  for (let i in gares) {
    ACPM.makeSet(gares[i].nom!);
  }

  for (let i in intergares) {
    let gare1 = ACPM.find(intergares[i].gare1!.nom!)!;
    let gare2 = ACPM.find(intergares[i].gare2!.nom!)!;

    if (gare1 !== gare2) {
      arbre.push(intergares[i]);
      ACPM.union(gare1, gare2);
    }
  }

  console.log(`Kruskal: Done in ${new Date().getTime() - dt}ms.`);
  console.log(
    `Kruskal: ${arbre.length} intergares in the ACPM with a ${arbre.reduce(
      (a, b) => a + b.time,
      0
    )}s total time.`
  );

  return arbre;
};

export const getFullTree = async () => {
  return (await clients.dataService.getIntergares(Empty).response).intergares;
};

export const generateImage = async (intergares: Intergare[]) => {
  return (
    await clients.canvasService.getCanvas({
      intergares
    }).response
  ).data;
};
