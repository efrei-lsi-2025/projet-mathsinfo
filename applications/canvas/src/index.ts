import { canvasServiceDefinition, setupServer } from '@metro-boulot-dodo/proto';
import { canvasService } from './service';

setupServer(canvasServiceDefinition, canvasService);
