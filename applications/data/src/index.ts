import { dataServiceDefinition, setupServer } from '@metro-boulot-dodo/proto';
import { dataService } from './service';

setupServer(dataServiceDefinition, dataService);
