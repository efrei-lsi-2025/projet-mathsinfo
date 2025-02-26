import {
  kruskalServiceDefinition,
  setupServer
} from '@metro-boulot-dodo/proto';
import { kruskalService } from './service';

setupServer(kruskalServiceDefinition, kruskalService);
