import { Entity } from 'typeorm';
import { Stats } from './stats.entity';

@Entity({ name: 'base_stats' })
export class BaseStats extends Stats {}
