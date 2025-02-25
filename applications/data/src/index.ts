import grpc from '@grpc/grpc-js';
import { dataServiceDefinition } from '@metro-boulot-dodo/proto';
import { dataService } from './service';

const host = process.env.HOST || '0.0.0.0:3000';

const server = new grpc.Server();
server.addService(dataServiceDefinition, dataService);

server.bind(host, grpc.ServerCredentials.createInsecure());
