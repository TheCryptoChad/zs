import { Blockchain } from 'src/utils/typeorm/entities/blockchain.entity';
import { Vessel } from 'src/utils/typeorm/entities/vessel.entity';
import { Users } from 'src/utils/typeorm/entities/users.entity';
import { Resource } from 'src/utils/typeorm/entities/resource/resource.entity';
import { ExhaustedTile } from './exhausted-tile.entity';
import { RandomSeed } from './random-seed.entity';
import { Stats } from './stats/stats.entity';
import { MantaStats } from './stats/manta.stats';
import { BaseStats } from './stats/base.stats';
import { supportedChainStats } from './stats';
import { supportedChainResources } from './resource';
import { Update } from './update.entity';
import { LoginTracker } from './login-tracker.entity';

export {
  Blockchain,
  ExhaustedTile,
  LoginTracker,
  RandomSeed,
  Resource,
  Vessel,
  Stats,
  MantaStats,
  BaseStats,
  Users,
  Update,
};

const entities = [
  Blockchain,
  ExhaustedTile,
  LoginTracker,
  RandomSeed,
  Resource,
  Vessel,
  Stats,
  Users,
  Update,
  ...Object.values(supportedChainStats),
  ...Object.values(supportedChainResources),
];

export default entities;
