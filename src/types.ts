export type Station = {
  num: number;
  nom: string;
  ligne: number;
  terminus: boolean;
  branchement: number;
  lat?: number;
  lng?: number;
};

export type Interstation = {
  station_1: Station | undefined;
  station_2: Station | undefined;
  temps: number;
}