import { BaseStats } from './base.stats';
import { MantaStats } from './manta.stats';
import { Stats } from './stats.entity';

export const supportedChainStats: { [key: number]: typeof Stats } = { 3_441_005: MantaStats, 8_453: BaseStats };
