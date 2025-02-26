import { db } from '@metro-boulot-dodo/database';
import {
  Empty,
  Gares,
  IDataService,
  Intergares,
  Lignes,
  sendUnaryData,
  ServerUnaryCall,
  Stations
} from '@metro-boulot-dodo/proto';

export const dataService: IDataService = {
  getGares: async (
    call: ServerUnaryCall<Empty, Gares>,
    callback: sendUnaryData<Gares>
  ) => {
    const gares = await db.gare.findMany({
      include: {
        lignes: true
      }
    });

    callback(null, {
      gares
    });
  },

  getIntergares: async (
    call: ServerUnaryCall<Empty, Intergares>,
    callback: sendUnaryData<Intergares>
  ) => {
    const intergares = await db.intergare.findMany({
      include: {
        gare1: {
          include: {
            lignes: true
          }
        },
        gare2: {
          include: {
            lignes: true
          }
        },
        ligne: true
      }
    });

    callback(null, {
      intergares
    });
  },

  getLignes: async (
    call: ServerUnaryCall<Empty, Lignes>,
    callback: sendUnaryData<Lignes>
  ) => {
    const lignes = await db.ligne.findMany();

    callback(null, {
      lignes
    });
  },

  getStations: async (
    call: ServerUnaryCall<Empty, Stations>,
    callback: sendUnaryData<Stations>
  ) => {
    const stations = await db.station.findMany({
      include: {
        ligne: true
      }
    });

    const adjacentStations = await db.adjacentStation.findMany({});

    callback(null, {
      stations: stations.map(station => ({
        num: station.num,
        nom: station.nom,
        branchement: station.branchement,
        posX: station.posX,
        posY: station.posY,
        terminus: station.terminus,
        ligne: station.ligne,
        adjacentStations: adjacentStations
          .filter(
            adjacent =>
              adjacent.station1Num === station.num ||
              adjacent.station2Num === station.num
          )
          .map(adjacent => ({
            time: adjacent.time,
            station: {
              ...stations.find(
                s =>
                  s.num ===
                  (adjacent.station1Num === station.num
                    ? adjacent.station2Num
                    : adjacent.station1Num)
              )!,
              adjacentStations: []
            }
          }))
      }))
    });
  }
};
