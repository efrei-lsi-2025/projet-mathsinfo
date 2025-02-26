import { Server, ServerCredentials } from '@grpc/grpc-js';
import {
  dataServiceDefinition,
  setupReflection
} from '@metro-boulot-dodo/proto';
import { dataService } from './service';

const host = process.env.HOST || '0.0.0.0:3000';

const server = new Server();
server.addService(dataServiceDefinition, dataService);

setupReflection(server);

server.bindAsync(host, ServerCredentials.createInsecure(), err => {
  if (err) {
    console.error(err);
    process.exit(1);
  }

  console.log(`Server listening on ${host}`);
});
