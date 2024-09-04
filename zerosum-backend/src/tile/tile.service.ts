import { BadRequestException, Injectable, OnModuleInit } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { randomInt } from 'crypto';
import { ExhaustedTile, Vessel, Users } from 'src/utils/typeorm/entities';
import { RandomSeed } from 'src/utils/typeorm/entities/random-seed.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TileService implements OnModuleInit {
  constructor(
    @InjectRepository(RandomSeed)
    private randomSeedRepository: Repository<RandomSeed>,
    @InjectRepository(ExhaustedTile)
    private exhaustedTileRepository: Repository<ExhaustedTile>,
    @InjectRepository(Vessel)
    private vesselRepository: Repository<Vessel>,
    @InjectRepository(Users)
    private userRepository: Repository<Users>,
  ) {}

  async onModuleInit() {
    try {
      const currentDayStart = this.getCurrentDayStart();
      const seeds = await this.randomSeedRepository.find();

      // If there's no seed or if the existing seed is older than 24 hours
      if (seeds.length === 0 || this.isSeedOutdated(seeds[0])) {
        await this.updateSeed(seeds, currentDayStart);
        await this.exhaustedTileRepository.clear();
      }
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async getExhaustedTilesForUser(
    uuid: string,
  ): Promise<{ uuid: string; x: number; y: number }[]> {
    try {
      return await this.exhaustedTileRepository.find({ where: { uuid: uuid } });
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async radarScan(
    uuid: string,
    vesselId: number,
  ): Promise<{ type: number; x: number; y: number }[]> {
    try {
      const vessel = await this.vesselRepository.findOne({
        where: { id: vesselId },
      });
      const user = await this.userRepository.findOne({ where: { uuid: uuid } });

      if (vessel.ownerAddress !== user.address)
        throw new BadRequestException('User does not own vessel!');

      const dailySeed: number = (
        await this.randomSeedRepository.findOne({ where: { id: 1 } })
      ).seed;

      const surroundingTiles = [];
      for (
        let dx: number = -Number(vessel.radar);
        dx <= Number(vessel.radar);
        dx++
      ) {
        for (
          let dy: number = -Number(vessel.radar);
          dy <= Number(vessel.radar);
          dy++
        ) {
          const proposedX: number = Number(vessel.x) + dx;
          const proposedY: number = Number(vessel.y) + dy;
          if (
            Math.sqrt(dx * dx + dy * dy) <= Number(vessel.radar) &&
            proposedX >= 1 &&
            proposedX <= 100 &&
            proposedY >= 1 &&
            proposedY <= 100
          ) {
            const adjustedX: number = Number(vessel.x) + dx;
            const adjustedY: number = Number(vessel.y) + dy;
            const tile = this.getTileTypeWithProbability(
              adjustedX,
              adjustedY,
              dailySeed,
            );
            surroundingTiles.push({ type: tile, x: adjustedX, y: adjustedY });
          }
        }
      }
      return surroundingTiles;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async determineTileType(
    uuid: string,
    vesselId: number,
  ): Promise<TileTypeData> {
    try {
      const vessel = await this.vesselRepository.findOne({
        where: { id: vesselId },
      });
      const user = await this.userRepository.findOne({ where: { uuid: uuid } });

      if (vessel.ownerAddress !== user.address)
        throw new BadRequestException('User does not own vessel!');

      const dailySeed: number = (
        await this.randomSeedRepository.findOne({ where: { id: 1 } })
      ).seed;

      const tileType = this.getTileTypeWithProbability(
        Number(vessel.x),
        Number(vessel.y),
        dailySeed,
      );

      let probabilities: {
        astralite: number;
        samarium: number;
        calamarite: number;
      };

      switch (tileType) {
        case 1:
          probabilities = {
            astralite: 33.33,
            samarium: 33.33,
            calamarite: 33.33,
          };
          break;
        case 2:
          probabilities = { astralite: 50, samarium: 25, calamarite: 25 };
          break;
        case 3:
          probabilities = { astralite: 25, samarium: 50, calamarite: 25 };
          break;
        case 4:
          probabilities = { astralite: 25, samarium: 25, calamarite: 50 };
          break;
        case 5:
          probabilities = { astralite: 80, samarium: 10, calamarite: 10 };
          break;
        case 6:
          probabilities = { astralite: 10, samarium: 80, calamarite: 10 };
          break;
        case 7:
          probabilities = { astralite: 10, samarium: 10, calamarite: 80 };
          break;
      }

      return { tileType, probabilities };
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private seededRandom(seed: number) {
    try {
      const x = Math.sin(seed) * 10_000;
      return x - Math.floor(x);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private getTileTypeWithProbability(x: number, y: number, dailySeed: number) {
    try {
      const cumulativeProbabilities = [0.55, 0.65, 0.75, 0.85, 0.9, 0.95, 1.0];

      const seed = x * 1000 + y + dailySeed;
      const rand = this.seededRandom(seed);

      let tileType: number;
      for (let i = 0; i < cumulativeProbabilities.length; i++) {
        if (rand < cumulativeProbabilities[i]) {
          tileType = i + 1;
          break;
        }
      }

      return tileType;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private async updateSeed(seeds: RandomSeed[], currentDayStart: number) {
    try {
      const seedEntity = seeds.length > 0 ? seeds[0] : new RandomSeed();
      seedEntity.seed = this.generateRandomSeed();
      seedEntity.generatedAt = currentDayStart;
      await this.randomSeedRepository.save(seedEntity);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private generateRandomSeed(): number {
    try {
      const min = 10000000; // 8 digits
      const max = 100000000; // 9 digits but exclusive
      return randomInt(min, max);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private isSeedOutdated(seed: RandomSeed): boolean {
    try {
      const TWENTY_FOUR_HOURS = 24 * 60 * 60; // in seconds
      const currentSecondsSinceEpoch = Math.floor(Date.now() / 1000);
      return currentSecondsSinceEpoch > seed.generatedAt + TWENTY_FOUR_HOURS;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private getCurrentDayStart(): number {
    try {
      const TWENTY_FOUR_HOURS = 24 * 60 * 60; // in seconds

      const currentSecondsSinceEpoch = Math.floor(Date.now() / 1000);
      return (
        currentSecondsSinceEpoch -
        (currentSecondsSinceEpoch % TWENTY_FOUR_HOURS)
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
