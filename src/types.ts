export type Station = {
  num: number;
  nom: string;
  ligne: string;
  terminus: boolean;
  branchement: number;
  lat?: number;
  lng?: number;
  adjacentStations: Station[];
  adjacentInterstations: Interstation[];
};

export type Interstation = {
  station_1?: Station;
  station_2?: Station;
  temps: number;
}