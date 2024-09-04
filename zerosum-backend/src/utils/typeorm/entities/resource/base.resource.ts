import { Entity } from 'typeorm';
import { Resource } from './resource.entity';

@Entity({ name: 'base_resource' })
export class BaseResource extends Resource {}
