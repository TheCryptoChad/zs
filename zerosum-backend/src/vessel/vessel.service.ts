import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Vessel } from '../utils/typeorm/entities/vessel.entity';
import { DataSource, Repository } from 'typeorm';
import entities, { ExhaustedTile, Users } from 'src/utils/typeorm/entities';
import { TileService } from 'src/tile/tile.service';
import { supportedChainResources } from 'src/utils/typeorm/entities/resource';
import migrations from 'src/utils/typeorm/migrations';

@Injectable()
export class VesselService {
  constructor(
    @InjectRepository(ExhaustedTile)
    private exhaustedTileRepository: Repository<ExhaustedTile>,
    @InjectRepository(Vessel)
    private vesselRepository: Repository<Vessel>,
    @InjectRepository(Users)
    private usersRepository: Repository<Users>,
    private readonly tileService: TileService,
  ) {}

  async getAllVessels(ownerUUID: string): Promise<Vessel[] | null> {
    try {
      const { address } = await this.usersRepository.findOne({
        where: {
          uuid: ownerUUID,
        },
      });

      if (!address)
        throw new BadRequestException(
          'Could not find address for user with id:',
          ownerUUID,
        );

      const vessels = await this.vesselRepository.find({
        where: { ownerAddress: address.toLowerCase() },
      });

      return vessels;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async getVessel(ownerAddress: string, id: number): Promise<Vessel | null> {
    try {
      return await this.vesselRepository.findOne({
        where: { id: id, ownerAddress: ownerAddress },
      });
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async deploy(uuid: string, id: number, x: number, y: number) {
    try {
      const vessel = await this.vesselRepository.findOne({ where: { id: id } });
      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      const exhaustedTile: ExhaustedTile =
        await this.exhaustedTileRepository.findOne({
          where: { uuid: uuid, x: x, y: y },
        });

      if (!vessel)
        throw new NotFoundException(`Vessel with ID ${id} not found`);
      if (user.address !== vessel.ownerAddress)
        throw new BadRequestException(`User does not own vessel with ID ${id}`);
      if (x < 1 || x > 100 || y < 1 || y > 100)
        throw new BadRequestException(`Vessel can't deploy outside of the map`);
      if (vessel.x !== null && vessel.y !== null)
        throw new BadRequestException(
          `Vessel with ID ${id} is already deployed`,
        );
      if (exhaustedTile !== null)
        throw new BadRequestException(
          `The tile at coordinates (${x}, ${y}) exhausted of resources`,
        );

      const surroundingVessels = await this.vesselRepository.find({
        where: { x: x, y: y, ownerAddress: user.address },
      });
      if (surroundingVessels.length > 0)
        throw new BadRequestException(
          'You already have a vessel in this location',
        );

      await this.vesselRepository.update(id, { x: x, y: y });
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async move(uuid: string, vesselId: number, x: number, y: number) {
    try {
      // 1. Get the vessel from the database using the provided nftId
      const vessel = await this.vesselRepository.findOne({
        where: { id: vesselId },
      });
      if (!vessel)
        throw new NotFoundException(`Vessel with ID ${vesselId} not found`);

      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      if (!user) throw new NotFoundException(`User with ID ${uuid} not found`);
      const exhaustedTile: ExhaustedTile =
        await this.exhaustedTileRepository.findOne({
          where: { uuid: uuid, x: x, y: y },
        });

      if (user.address !== vessel.ownerAddress)
        throw new BadRequestException(
          `User does not own vessel with ID ${vesselId}`,
        );
      if (vessel.x === null && vessel.y === null)
        throw new BadRequestException(
          `Vessel with ID ${vesselId} is not deployed`,
        );
      if (x < 1 || x > 100 || y < 1 || y > 100)
        throw new BadRequestException(`Vessel can't move outside of the map`);
      if (vessel.miningEndTime !== null)
        throw new BadRequestException(
          `Vessel with ID ${vesselId} is currently mining`,
        );
      if (vessel.isLocked)
        throw new BadRequestException(
          `Vessel with ID ${vesselId} is currently being transferred`,
        );

      const surroundingVessels = await this.vesselRepository.find({
        where: { x: x, y: y, ownerAddress: vessel.ownerAddress },
      });
      if (surroundingVessels.length > 0)
        throw new BadRequestException(
          'You already have a vessel in this location',
        );

      // 3. Verify that the new position is within the vessel's range
      // Euclidean distance calculation
      const range = Number(vessel.range);
      const distance = Math.sqrt(
        Math.pow(Number(vessel.x) - x, 2) + Math.pow(Number(vessel.y) - y, 2),
      );
      if (distance > range)
        throw new BadRequestException(
          `Target position is outside of vessel's range`,
        );

      // 4. If all checks passed, update the X and Y coordinates of the vessel
      const updatedVessel = await this.vesselRepository.update(vesselId, {
        x: x,
        y: y,
      });
      return updatedVessel;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async startMining(uuid: string, id: number) {
    try {
      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      const vessel: Vessel = await this.vesselRepository.findOne({
        where: { id: id },
      });
      const exhaustedTile: ExhaustedTile =
        await this.exhaustedTileRepository.findOne({
          where: { uuid: uuid, x: vessel.x, y: vessel.y },
        });

      const date: Date = new Date();
      const oneMinute = 60_000;
      const miningEndTime: number =
        date.getTime() + oneMinute * (1 - Number(vessel.speed) * 0.05);

      if (vessel.ownerAddress !== user.address)
        throw new BadRequestException(`User does not own vessel with ID ${id}`);
      if (vessel.x === null || vessel.y === null)
        throw new BadRequestException(`Vessel with ID ${id} is not deployed`);
      if (exhaustedTile !== null)
        throw new BadRequestException(
          `The tile at coordinates (${vessel.x}, ${vessel.y}) exhausted of resources`,
        );
      if (vessel.miningEndTime)
        throw new BadRequestException(`Vessel with ID ${id} is already mining`);
      if (vessel.isLocked)
        throw new BadRequestException(
          `Vessel with ID ${id} is currently being transferred`,
        );

      const tileTypeData: TileTypeData =
        await this.tileService.determineTileType(uuid, vessel.id);
      const randomSeed: number = Math.random();
      let randomResource = 0;
      let randomAmount = 0;

      switch (tileTypeData.tileType) {
        //Balanced
        case 1:
          randomResource = Math.floor(randomSeed * 3) + 1;
          randomAmount = Math.floor(randomSeed * (500 - 300 + 1) + 300);
          break;
        //50% Astralite
        case 2:
          randomResource = randomSeed < 0.5 ? 1 : randomSeed < 0.75 ? 2 : 3;
          randomAmount = Math.floor(randomSeed * (600 - 250 + 1) + 250);
          break;
        //50% Samarium
        case 3:
          randomResource = randomSeed < 0.5 ? 2 : randomSeed < 0.75 ? 1 : 3;
          randomAmount = Math.floor(randomSeed * (600 - 250 + 1) + 250);
          break;
        //50% Calamarite
        case 4:
          randomResource = randomSeed < 0.5 ? 3 : randomSeed < 0.75 ? 2 : 1;
          randomAmount = Math.floor(randomSeed * (600 - 250 + 1) + 250);
          break;
        //80% Astralite
        case 5:
          randomResource = randomSeed < 0.8 ? 1 : randomSeed < 0.9 ? 2 : 3;
          randomAmount = Math.floor(randomSeed * (750 - 500 + 1) + 500);
          break;
        //80% Samarium
        case 6:
          randomResource = randomSeed < 0.8 ? 2 : randomSeed < 0.9 ? 1 : 3;
          randomAmount = Math.floor(randomSeed * (750 - 500 + 1) + 500);
          break;
        //80% Calamarite
        case 7:
          randomResource = randomSeed < 0.8 ? 3 : randomSeed < 0.9 ? 2 : 1;
          randomAmount = Math.floor(randomSeed * (750 - 500 + 1) + 500);
          break;
      }

      switch (randomResource) {
        case 1:
          await this.vesselRepository
            .createQueryBuilder()
            .update()
            .set({
              pendingAstralite: randomAmount,
              miningEndTime: miningEndTime,
            })
            .where('id = :id', {
              id: id,
            })
            .execute();
          break;
        case 2:
          await this.vesselRepository
            .createQueryBuilder()
            .update()
            .set({
              pendingSamarium: randomAmount,
              miningEndTime: miningEndTime,
            })
            .where('id = :id', {
              id: id,
            })
            .execute();
          break;
        case 3:
          await this.vesselRepository
            .createQueryBuilder()
            .update()
            .set({
              pendingCalamarite: randomAmount,
              miningEndTime: miningEndTime,
            })
            .where('id = :id', {
              id: id,
            })
            .execute();
          break;
      }
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  async finishMining(uuid: string, vesselId: number) {
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

      const user = await this.usersRepository.findOne({
        where: { uuid: uuid },
      });
      const vessel: Vessel = await this.vesselRepository.findOne({
        where: { id: vesselId },
      });
      const exhaustedTile: ExhaustedTile =
        await this.exhaustedTileRepository.findOne({
          where: { uuid: uuid, x: vessel.x, y: vessel.y },
        });

      const date: Date = new Date();
      let resourceType = '';
      let awardedAmount = 0;

      if (vessel.ownerAddress !== user.address)
        throw new BadRequestException(
          `User does not own vessel with ID ${vesselId}`,
        );
      if (!vessel.miningEndTime)
        throw new BadRequestException(
          `Vessel with ID ${vesselId} is not mining`,
        );
      if (vessel.miningEndTime > date.getTime())
        throw new BadRequestException(
          `Vessel with ID ${vesselId} hasn't finished mining yet`,
        );
      if (vessel.isLocked)
        throw new BadRequestException(
          `Vessel with ID ${vesselId} is currently being transferred`,
        );
      if (exhaustedTile !== null)
        throw new BadRequestException(
          `The tile at coordinates (${vessel.x}, ${vessel.y}) exhausted of resources`,
        );

      if (vessel.pendingAstralite !== null) {
        Object.values(supportedChainResources).map(async (chainResource) => {
          await dataSource
            .getRepository(chainResource)
            .createQueryBuilder()
            .update()
            .set({ astralite: () => `astralite + ${vessel.pendingAstralite}` })
            .where('owner_address = :ownerAddress', {
              ownerAddress: vessel.ownerAddress,
            })
            .execute();
        });
        resourceType = 'astralite';
        awardedAmount = vessel.pendingAstralite;
      }
      if (vessel.pendingSamarium !== null) {
        Object.values(supportedChainResources).map(async (chainResource) => {
          await dataSource
            .getRepository(chainResource)
            .createQueryBuilder()
            .update()
            .set({ samarium: () => `samarium + ${vessel.pendingSamarium}` })
            .where('owner_address = :ownerAddress', {
              ownerAddress: vessel.ownerAddress,
            })
            .execute();
        });
        resourceType = 'samarium';
        awardedAmount = vessel.pendingSamarium;
      }
      if (vessel.pendingCalamarite !== null) {
        Object.values(supportedChainResources).map(async (chainResource) => {
          await dataSource
            .getRepository(chainResource)
            .createQueryBuilder()
            .update()
            .set({
              calamarite: () => `calamarite + ${vessel.pendingCalamarite}`,
            })
            .where('owner_address = :ownerAddress', {
              ownerAddress: vessel.ownerAddress,
            })
            .execute();
        });
        resourceType = 'calamarite';
        awardedAmount = vessel.pendingCalamarite;
      }

      await this.vesselRepository
        .createQueryBuilder()
        .update()
        .set({
          miningEndTime: null,
          pendingAstralite: null,
          pendingSamarium: null,
          pendingCalamarite: null,
        })
        .where('id = :id', { id: vesselId })
        .execute();

      await this.exhaustedTileRepository.save({
        uuid: uuid,
        x: vessel.x,
        y: vessel.y,
      });

      // return the type and amount of resources awarded
      return {
        resourceType,
        awardedAmount,
      };
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
