import { BaseResource } from './base.resource';
import { MantaResource } from './manta.resource';
import { Resource } from './resource.entity';

export const supportedChainResources: { [key: number]: typeof Resource } = { 3_441_005: MantaResource, 8_453: BaseResource };
