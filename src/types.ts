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

export type Interstation = {
  station_1?: Station;
  station_2?: Station;
  time: number;
}