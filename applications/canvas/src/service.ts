import {
  CanvasDrawRequest,
  ICanvasService,
  Image,
  sendUnaryData,
  ServerUnaryCall
} from '@metro-boulot-dodo/proto';
import { createMapCanvas } from './canvas';

export const canvasService: ICanvasService = {
  getCanvas: async (
    call: ServerUnaryCall<CanvasDrawRequest, Image>,
    callback: sendUnaryData<Image>
  ) => {
    const image = await createMapCanvas(call.request.intergares);
    const imageBytes = image.toBuffer();

    callback(null, {
      data: imageBytes
    });
  }
};
