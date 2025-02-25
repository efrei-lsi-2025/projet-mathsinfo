import { Intergare } from '@metro-boulot-dodo/proto';
import { KruskalSet } from './utils';

export const kruskal = () => {
  console.log(`Kruskal: Starting...`);
  let dt = new Date().getTime();

  const garesCopy = [
    ...gares.map(g => ({
      nom: g.nom,
      lignes: g.lignes,
      posX: g.posX,
      posY: g.posY
    }))
  ];
  const intergaresCopy = [
    ...intergares.map(i => ({
      gare_1: garesCopy.find(g => g.nom === i.gare_1.nom),
      gare_2: garesCopy.find(g => g.nom === i.gare_2.nom),
      ligne: i.ligne,
      time: i.time
    }))
  ];

  const arbre: Intergare[] = [];
  const ACPM = new KruskalSet();

  intergaresCopy.sort((a, b) => a.time - b.time);

  for (let i in garesCopy) {
    ACPM.makeSet(garesCopy[i]);
  }

  for (let i in intergaresCopy) {
    let gare1 = ACPM.find(intergaresCopy[i].gare_1);
    let gare2 = ACPM.find(intergaresCopy[i].gare_2);

    if (gare1 !== gare2) {
      arbre.push(intergaresCopy[i]);
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
