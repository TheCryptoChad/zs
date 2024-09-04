import { Entity } from 'typeorm';
import { Stats } from './stats.entity';

@Entity({ name: 'manta_stats' })
export class MantaStats extends Stats {}
