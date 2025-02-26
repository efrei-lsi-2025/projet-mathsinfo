import {
  IDijkstraService,
  sendUnaryData,
  ServerUnaryCall,
  ShortestPathRequest,
  ShortestPathResponse
} from '@metro-boulot-dodo/proto';
import { dijkstra } from './path';

export const dijkstraService: IDijkstraService = {
  getShortestPath: async (
    call: ServerUnaryCall<ShortestPathRequest, ShortestPathResponse>,
    callback: sendUnaryData<ShortestPathResponse>
  ) => {
    const { path, time } = await dijkstra(
      call.request.start!,
      call.request.end!
    );

    callback(null, {
      path,
      time
    });
  }
};
