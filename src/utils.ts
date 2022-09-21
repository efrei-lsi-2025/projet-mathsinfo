import { stations } from ".";
import { AdjacentStation, Station } from "./types";

function getMetroColor(line: string) {
  switch (line) {
    case "1":
      return "#ffcd00";
    case "2":
      return "#003da5";
    case "3":
      return "#827a04";
    case "3bis":
      return "#71c5e8";
    case "4":
      return "#c800a1";
    case "5":
      return "#ff7f32";
    case "6":
      return "#71cc98";
    case "7":
      return "#f59bbb";
    case "7bis":
      return "#71cc98";
    case "8":
      return "#dd9cdf";
    case "9":
      return "#b5bd00";
    case "10":
      return "#c69214";
    case "11":
      return "#6e4c1e";
    case "12":
      return "#007a53";
    case "13":
      return "#71c5e8";
    case "14":
      return "#5f259f";
    case "15":
      return "#a50034";
    case "16":
      return "#f59bbb";
    case "17":
      return "#b5bd00";
    case "18":
      return "#00ab8e";
    default:
      return "#000";
  }
}

function getTerminusFromTwoStations(s1: Station, s2: Station, alreadyVisited: Station[] = []) {
  if(s1.ligne !== s2.ligne) {
    throw new Error("Stations are not on the same line.");
  }

  if(s2.terminus) {
    return s2;
  } else {
    alreadyVisited.push(s1);
    const adj = s1.adjacentStations.filter(adj => !alreadyVisited.includes(adj.station) && adj.station.ligne === s1.ligne);
    if(adj.length === 1) {
      return getTerminusFromTwoStations(s1, adj[0].station, alreadyVisited);
    } else if (adj.length === 2) {
      const terminus1 = getTerminusFromTwoStations(s1, adj[0].station, alreadyVisited);
      const terminus2 = getTerminusFromTwoStations(s1, adj[1].station, alreadyVisited);
      return [terminus1, terminus2];
    } else {
      throw new Error("Cannot find terminus.");
    }
  }
}

export {getMetroColor, getTerminusFromTwoStations};