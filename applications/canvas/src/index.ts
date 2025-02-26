import { Server, ServerCredentials } from '@grpc/grpc-js';
import {
  canvasServiceDefinition,
  setupReflection
} from '@metro-boulot-dodo/proto';
import { canvasService } from './service';

const host = process.env.HOST || '0.0.0.0:3000';

const server = new Server();
server.addService(canvasServiceDefinition, canvasService);

setupReflection(server);

server.bindAsync(host, ServerCredentials.createInsecure(), err => {
  if (err) {
    console.error(err);
    process.exit(1);
  }

  console.log(`Server listening on ${host}`);
});
