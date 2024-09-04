import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import entities, { Users, Stats } from 'src/utils/typeorm/entities';
import { supportedChainStats } from 'src/utils/typeorm/entities/stats';
import migrations from 'src/utils/typeorm/migrations';
import { DataSource, Repository } from 'typeorm';
import { LoginTracker } from '../utils/typeorm/entities/login-tracker.entity';

const fetch = require('node-fetch');

@Injectable()
export class StatsService {
  constructor(
    @InjectRepository(Users)
    private readonly usersRepository: Repository<Users>,
  ) {}

  async fetchStats(
    resource: 'astralite' | 'samarium' | 'calamarite' | 'all',
    type: 'amount' | 'tx' | 'faucet' | 'gas',
    scope: 'dashboard' | 'leaderboard',
    chain: number,
    uuid: string,
  ) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      const backendAddress: string =
        '0xaac5e7e4d9d3b535a286e5a784d64d67af7dd4a1';
      const columnName: string =
        type === 'faucet'
          ? 'faucet_uses'
          : type === 'gas'
          ? 'gas_tx'
          : `${resource}_${type}`;
      const entityProperty: string =
        type === 'faucet'
          ? 'faucetUses'
          : type === 'gas'
          ? 'gasTx'
          : `${resource}${type.charAt(0).toUpperCase() + type.slice(1)}`;
      let shouldBreak: boolean = false;

      if (scope === 'dashboard') {
        const dashboard: Stats = {
          address: backendAddress,
          astraliteAmount: 0,
          astraliteTx: 0,
          samariumAmount: 0,
          samariumTx: 0,
          calamariteAmount: 0,
          calamariteTx: 0,
          faucetUses: 0,
          gasTx: 0,
        };

        await Promise.all(
          Object.keys(supportedChainStats).map(async (chainId) => {
            if (!shouldBreak) {
              const chainDashboard = await dataSource
                .getRepository(
                  supportedChainStats[Number(chain > 0 ? chain : chainId)],
                )
                .findOne({ where: { address: backendAddress } });
              Object.keys(dashboard).map((stat) => {
                if (stat !== 'address' && !shouldBreak)
                  dashboard[stat] += Number(chainDashboard[stat]);
              });
            }
            if (chain > 0) shouldBreak = true;
          }),
        );
        return dashboard;
      }
      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      const players = [];

      await Promise.all(
        Object.keys(supportedChainStats).map(async (chainId) => {
          if (!shouldBreak) {
            const queryBuilder = dataSource
              .getRepository(
                supportedChainStats[Number(chain > 0 ? chain : chainId)],
              )
              .createQueryBuilder()
              .where('address <> :excluded', { excluded: backendAddress });

            resource === 'all'
              ? queryBuilder
                  .orderBy(`astralite_${type}`, 'DESC')
                  .addOrderBy(`samarium_${type}`, 'DESC')
                  .addOrderBy(`calamarite_${type}`, 'DESC')
              : queryBuilder.orderBy(columnName, 'DESC');

            const chainPlayers = await queryBuilder.getMany();

            chainPlayers.map((chainPlayer) => {
              const player = players.find(
                (player) => player.address === chainPlayer.address,
              );
              if (player) {
                const index = players.indexOf(player);
                Object.keys(chainPlayer).map((stat) => {
                  if (stat !== 'address' && !shouldBreak)
                    players[index][stat] =
                      Number(players[index][stat]) + Number(chainPlayer[stat]);
                });
              } else {
                players.push(chainPlayer);
              }
            });
          }
          if (chain > 0) shouldBreak = true;
        }),
      );

      if (resource === 'all') {
        players.sort(
          (a: Stats, b: Stats) =>
            Number(
              b[`astralite${type.charAt(0).toUpperCase() + type.slice(1)}`],
            ) +
            Number(
              b[`samarium${type.charAt(0).toUpperCase() + type.slice(1)}`],
            ) +
            Number(
              b[`calamarite${type.charAt(0).toUpperCase() + type.slice(1)}`],
            ) -
            (Number(
              a[`astralite${type.charAt(0).toUpperCase() + type.slice(1)}`],
            ) +
              Number(
                a[`samarium${type.charAt(0).toUpperCase() + type.slice(1)}`],
              ) +
              Number(
                a[`calamarite${type.charAt(0).toUpperCase() + type.slice(1)}`],
              )),
        );
      } else {
        players.sort(
          (a: Stats, b: Stats) =>
            Number(b[entityProperty]) - Number(a[entityProperty]),
        );
      }

      const player = players.find((player) => player.address === user.address);

      const leaderboard: {
        position: number;
        image: string;
        address: string;
        stat: number;
      }[] = [];

      for (let i: number = 0; i < 10; i++) {
        const playerStat = await this.usersRepository.findOne({
          where: { address: players[i].address },
        });
        const image = await fetch(
          `https://customizer-api.moonsama.com/api/v1/public/user/${playerStat.username}/avatar/pfp/file`,
        );
        resource === 'all'
          ? leaderboard.push({
              position: i + 1,
              image:
                playerStat.username && playerStat.linkedUsername && image.ok
                  ? `https://customizer-api.moonsama.com/api/v1/public/user/${playerStat.username}/avatar/pfp/file`
                  : '/default-avatar.png',
              address:
                playerStat.username && playerStat.linkedUsername
                  ? playerStat.username
                  : this.censorAddress(players[i].address),
              stat:
                Number(
                  players[i][
                    `astralite${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ) +
                Number(
                  players[i][
                    `samarium${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ) +
                Number(
                  players[i][
                    `calamarite${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ),
            })
          : leaderboard.push({
              position: i + 1,
              image:
                playerStat.username && playerStat.linkedUsername && image.ok
                  ? `https://customizer-api.moonsama.com/api/v1/public/user/${playerStat.username}/avatar/pfp/file`
                  : '/default-avatar.png',
              address:
                playerStat.username && playerStat.linkedUsername
                  ? playerStat.username
                  : this.censorAddress(players[i].address),
              stat: Number(players[i][entityProperty]),
            });
      }

      if (players.indexOf(player) > 9) {
        const image = await fetch(
          `https://customizer-api.moonsama.com/api/v1/public/user/${user.username}/avatar/pfp/file`,
        );
        resource === 'all'
          ? leaderboard.push({
              position: players.indexOf(player) + 1,
              image:
                user.username && user.linkedUsername && image.ok
                  ? `https://customizer-api.moonsama.com/api/v1/public/user/${user.username}/avatar/pfp/file`
                  : '/default-avatar.png',
              address:
                user.username && user.linkedUsername
                  ? user.username
                  : this.censorAddress(player.address),
              stat:
                Number(
                  player[
                    `astralite${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ) +
                Number(
                  player[
                    `samarium${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ) +
                Number(
                  player[
                    `calamarite${type.charAt(0).toUpperCase() + type.slice(1)}`
                  ],
                ),
            })
          : leaderboard.push({
              position: players.indexOf(player) + 1,
              image:
                user.username && user.linkedUsername && image.ok
                  ? `https://customizer-api.moonsama.com/api/v1/public/user/${user.username}/avatar/pfp/file`
                  : '/default-avatar.png',
              address:
                user.username && user.linkedUsername
                  ? user.username
                  : this.censorAddress(player.address),
              stat: Number(player[entityProperty]),
            });
      }

      return leaderboard;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async fetchLogins(type: 'total' | 'consecutive' | 'daily' | 'referrals', uuid: string) {
    try {
      const dataSource = await new DataSource({
        type: 'postgres',
        host: `${process.env.PGHOST}`,
        port: Number(process.env.PGPORT),
        username: `${process.env.PGUSER}`,
        password: `${process.env.PGPASSWORD}`,
        database: `${process.env.PGDATABASE}`,
        entities: entities,
        migrations: migrations,
      }).initialize();

      if (type === 'daily')
        return await dataSource
          .getRepository(LoginTracker)
          .createQueryBuilder()
          .orderBy('date', 'DESC')
          .getMany();

      const users = await dataSource
        .getRepository(Users)
        .createQueryBuilder()
        .orderBy(`${type !== 'referrals' ? `${type}_logins` : `array_length(referrals, 1)`}`, `${type !== 'referrals' ? 'DESC' : 'ASC'}`)
        .getMany();

      const user = users.find((user: any) => user.uuid === uuid);

      const leaderboard: {
        position: number;
        image: string;
        address: string;
        stat: number;
      }[] = [];

      for (let i: number = 0; i < 10; i++) {
        const image = await fetch(
          `https://customizer-api.moonsama.com/api/v1/public/user/${users[i].username}/avatar/pfp/file`,
        );
        leaderboard.push({
          position: i + 1,
          image:
            users[i].username && users[i].linkedUsername && image.ok
              ? `https://customizer-api.moonsama.com/api/v1/public/user/${users[i].username}/avatar/pfp/file`
              : '/default-avatar.png',
          address:
            users[i].username && users[i].linkedUsername
              ? users[i].username
              : this.censorAddress(users[i].address),
          stat: Number(type !== 'referrals' ? users[i][`${type}Logins`] : users[i][type].length),
        });
      }

      if (users.indexOf(user) > 9) {
        const image = await fetch(
          `https://customizer-api.moonsama.com/api/v1/public/user/${user.username}/avatar/pfp/file`,
        );
        leaderboard.push({
          position: users.indexOf(user) + 1,
          image:
            user.username && user.linkedUsername && image.ok
              ? `https://customizer-api.moonsama.com/api/v1/public/user/${user.username}/avatar/pfp/file`
              : '/default-avatar.png',
          address:
            user.username && user.linkedUsername
              ? user.username
              : this.censorAddress(user.address),
          stat: Number(type !== 'referrals' ? user[`${type}Logins`] : user[type].length),
        });
      }

      return leaderboard;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private censorAddress(address: string): string {
    try {
      if (!address) return '0x0000...0000';
      const firstHalf = address.substring(0, 5);
      const secondHalf = address.substring(address.length - 4, address.length);
      return `${firstHalf}...${secondHalf}`;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
