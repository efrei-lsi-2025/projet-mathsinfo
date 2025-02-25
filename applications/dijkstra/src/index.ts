import { AdjacentStation, Station } from '@metro-boulot-dodo/proto';

export const dijkstra = (start: Station, end: Station) => {
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
  while (
    (stationActuelle = unvisited
      .sort((a, b) => PCC[a.num].time - PCC[b.num].time)
      .shift())
  ) {
    // On récupère les stations adjacentes qui n'ont pas encore été visitées
    let stationsAdjacentes = stations
      .find(station => station.num === stationActuelle.num)
      .adjacentStations.filter(
        n => visited.filter(v => v.num === n.station.num).length === 0
      );

    // On ajoute les voisins dans la liste des stations pas encore visitées
    unvisited.push(...stationsAdjacentes.map(n => n.station));

    let timeToStation = PCC[stationActuelle.num].time;

    for (let st of stationsAdjacentes) {
      let timeVoisin = PCC[st.station.num] && PCC[st.station.num].time;
      let nouveauCout = timeToStation + st.time;
      if (timeVoisin === undefined || nouveauCout < timeVoisin) {
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
  console.log(
    `Dijkstra: Path from ${start.nom} to ${end.nom}:\n${path
      .map(s => s.nom)
      .join(' -> ')}`
  );

  return {
    path,
    time: PCC[end.num].time
  };
};
