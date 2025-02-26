import {
  Empty,
  IKruskalService,
  Image,
  sendUnaryData,
  ServerUnaryCall
} from '@metro-boulot-dodo/proto';
import { generateImage, generateMST, getFullTree } from './tree';

export const kruskalService: IKruskalService = {
  getMinimumSpanningTree: async (
    call: ServerUnaryCall<Empty, Image>,
    callback: sendUnaryData<Image>
  ) => {
    const mst = await generateMST();
    const imageBytes = await generateImage(mst);

    callback(null, {
      data: imageBytes
    });
  },

  getFullTree: async (
    call: ServerUnaryCall<Empty, Image>,
    callback: sendUnaryData<Image>
  ) => {
    const fullTree = await getFullTree();
    const imageBytes = await generateImage(fullTree);

    callback(null, {
      data: imageBytes
    });
  }
};
