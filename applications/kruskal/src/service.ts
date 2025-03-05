import {
  Empty,
  IKruskalService,
  Intergares,
  sendUnaryData,
  ServerUnaryCall
} from '@metro-boulot-dodo/proto';
import { generateMST } from './tree';

export const kruskalService: IKruskalService = {
  getMinimumSpanningTree: async (
    call: ServerUnaryCall<Empty, Intergares>,
    callback: sendUnaryData<Intergares>
  ) => {
    const mst = await generateMST();

    callback(null, {
      intergares: mst
    });
  }
};
