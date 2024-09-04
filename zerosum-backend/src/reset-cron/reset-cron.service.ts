import { Injectable, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { InjectRepository } from '@nestjs/typeorm';
import { RandomSeed, ExhaustedTile, Users, LoginTracker } from 'src/utils/typeorm/entities';
import { Repository } from 'typeorm';
import { randomInt } from 'crypto';

@Injectable()
export class ResetCronService {
  private readonly logger = new Logger(ResetCronService.name);
  private readonly TWENTY_FOUR_HOURS = 24 * 60 * 60; // in seconds

  constructor(
    @InjectRepository(RandomSeed)
    private randomSeedRepository: Repository<RandomSeed>,
    @InjectRepository(ExhaustedTile)
    private exhaustedTileRepository: Repository<ExhaustedTile>,
    @InjectRepository(Users)
    private usersRepository: Repository<Users>,
    @InjectRepository(LoginTracker)
    private loginTrackerRepository: Repository<LoginTracker>,
  ) {}

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT, {
    timeZone: 'UTC',
  })
  async handleCron() {
    try {
      this.logger.log('Resetting Seed, cleaning exhausted tiles...');
      const currentDayStart = this.getCurrentDayStart();
      const newSeed = this.generateRandomSeed();
      await this.randomSeedRepository.update(1, {
        seed: newSeed,
        generatedAt: currentDayStart,
      });
      const seeds = await this.randomSeedRepository.find();
      this.logger.log(`Finished resetting seed, new seed: ${seeds[0].seed}`);

      this.logger.log('Clearing exhausted tiles...');
      const count = await this.exhaustedTileRepository.count();
      await this.exhaustedTileRepository.clear();
      this.logger.log(`Cleared ${count} exhausted tiles!`);

      this.logger.log('Updating login stats...');
      const dailyUsers = await this.updateLoginStats(currentDayStart);
      this.logger.log(`Login stats updated, yesterday ${dailyUsers} users played Zero Sum!`);
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

  private getCurrentDayStart(): number {
    try {
      const currentSecondsSinceEpoch = Math.floor(Date.now() / 1000);
      return (
        currentSecondsSinceEpoch -
        (currentSecondsSinceEpoch % this.TWENTY_FOUR_HOURS)
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private async updateLoginStats(currentDayStart: number): Promise<number>{
    try {
      const users: Users[] = await this.usersRepository.find();
      let dailyUsers: number = 0;

      await Promise.all(users.map(async (user: Users) => {
        const loginTimeSeconds: number = Math.floor(Number(user.lastLogin) / 1000);
        const didLoginToday = loginTimeSeconds >= (currentDayStart - this.TWENTY_FOUR_HOURS) && loginTimeSeconds < currentDayStart;
        if(didLoginToday) {
          await this.usersRepository.update(user.uuid, { totalLogins: Number(user.totalLogins) + 1, consecutiveLogins: Number(user.consecutiveLogins) + 1 });
          dailyUsers++;
        } else {
          await this.usersRepository.update(user.uuid, { consecutiveLogins: 0 });
        }
      }));

      await this.loginTrackerRepository.insert({ date: (currentDayStart - this.TWENTY_FOUR_HOURS) * 1_000, totalLogins: dailyUsers });

      return dailyUsers;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
