import { Server, ServerCredentials } from '@grpc/grpc-js';
import {
  kruskalServiceDefinition,
  setupReflection
} from '@metro-boulot-dodo/proto';
import { kruskalService } from './service';

const host = process.env.HOST || '0.0.0.0:3000';

const server = new Server();
server.addService(kruskalServiceDefinition, kruskalService);

setupReflection(server);

server.bindAsync(host, ServerCredentials.createInsecure(), err => {
  if (err) {
    console.error(err);
    process.exit(1);
  }

  console.log(`Server listening on ${host}`);
});
