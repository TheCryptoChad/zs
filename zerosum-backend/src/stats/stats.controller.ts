import { Controller, Get, Query, Req } from '@nestjs/common';
import { StatsService } from './stats.service';

@Controller('stats')
export class StatsController {
  constructor(private readonly statsService: StatsService) {}

  @Get('/fetch-stats')
  async fetchStats(
    @Req() req: Express.Request,
    @Query()
    queryParams: {
      resource: 'astralite' | 'samarium' | 'calamarite' | 'all';
      type: 'amount' | 'tx' | 'faucet' | 'gas';
      scope: 'dashboard' | 'leaderboard';
      chain: string;
    },
  ) {
    try {
      return this.statsService.fetchStats(
        queryParams.resource,
        queryParams.type,
        queryParams.scope,
        Number(queryParams.chain),
        req.user.uuid,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/fetch-logins')
  async fetchLogins(
    @Req() req: Express.Request,
    @Query()
    queryParams: {
      type: 'total' | 'consecutive' | 'daily' | 'referrals';
    },
  ) {
    try {
      return await this.statsService.fetchLogins(
        queryParams.type,
        req.user.uuid,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
