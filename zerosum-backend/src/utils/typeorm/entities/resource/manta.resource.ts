import { Entity } from 'typeorm';
import { Resource } from './resource.entity';

@Entity({ name: 'manta_resource' })
export class MantaResource extends Resource {}
