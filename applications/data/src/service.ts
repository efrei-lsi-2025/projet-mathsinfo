import { sendUnaryData, ServerUnaryCall } from '@grpc/grpc-js';
import {
  Empty,
  Gares,
  IDataService,
  Intergares,
  Lignes,
  Stations
} from '@metro-boulot-dodo/proto';

export const dataService: IDataService = {
  getGares: (
    call: ServerUnaryCall<Empty, Gares>,
    callback: sendUnaryData<Gares>
  ) => {
    callback(null, {
      gares: []
    });
  },

  getIntergares: (
    call: ServerUnaryCall<Empty, Intergares>,
    callback: sendUnaryData<Intergares>
  ) => {
    callback(null, {
      intergares: []
    });
  },

  getLignes: (
    call: ServerUnaryCall<Empty, Lignes>,
    callback: sendUnaryData<Lignes>
  ) => {
    callback(null, {
      lignes: []
    });
  },

  getStations: (
    call: ServerUnaryCall<Empty, Stations>,
    callback: sendUnaryData<Stations>
  ) => {
    callback(null, {
      stations: []
    });
  }
};
