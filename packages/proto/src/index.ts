import { ChannelCredentials, Server } from '@grpc/grpc-js';
import { loadSync } from '@grpc/proto-loader';
import { ReflectionService } from '@grpc/reflection';
import { GrpcTransport } from '@protobuf-ts/grpc-transport';
import path from 'path';
import * as generated from './generated/index.js';

export const clients = {
  dataService: new generated.DataServiceClient(
    new GrpcTransport({
      host: 'data:3000',
      channelCredentials: ChannelCredentials.createInsecure()
    })
  ),
  canvasService: new generated.CanvasServiceClient(
    new GrpcTransport({
      host: 'canvas:3000',
      channelCredentials: ChannelCredentials.createInsecure()
    })
  ),
  kruskalService: new generated.KruskalServiceClient(
    new GrpcTransport({
      host: 'kruskal:3000',
      channelCredentials: ChannelCredentials.createInsecure()
    })
  ),
  dijkstraService: new generated.DijkstraServiceClient(
    new GrpcTransport({
      host: 'dijkstra:3000',
      channelCredentials: ChannelCredentials.createInsecure()
    })
  )
};

export const setupReflection = (server: Server) => {
  const packageDefinition = loadSync(
    path.join(__dirname, '../protos/data.proto')
  );

  const reflection = new ReflectionService(packageDefinition);
  reflection.addToServer(server);
};

export * from '@grpc/grpc-js';
export * from './generated/index.js';
