import {
  dijkstraServiceDefinition,
  setupServer
} from '@metro-boulot-dodo/proto';
import { dijkstraService } from './service';

setupServer(dijkstraServiceDefinition, dijkstraService);
