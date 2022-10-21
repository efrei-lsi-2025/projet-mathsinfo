// Structure pour Kruskal

// Une gare est un noeud unique du graphe (on va ignorer les temps de correspondances dans la même gare pour simplifier et rendre Kruskal plus visuel)
export type Gare = {
  nom: string;
  lignes: string[];
  lat?: number;
  lng?: number;
};

export type Intergare = {
  gare_1?: Gare;
  gare_2?: Gare;
  time: number;
  ligne: string;
}

// Structure de données pour Dijkstra

export type Station = {
  num: number;
  nom: string;
  ligne: string;
  terminus: boolean;
  branchement: number;
  lat?: number;
  lng?: number;
  adjacentStations: AdjacentStation[];
};

export type AdjacentStation = {
  time: number;
  station: Station;
};