import { Users } from '../typeorm/entities/users.entity';

declare global {
  namespace Express {
    export interface Request {
      user: Users;
    }
  }

  namespace Moonsama {
    type TokensResponse = {
      access_token: string;
      token_type: string;
      expires_in: number;
      refresh_token: string;
      refresh_token_expires_in: number;
    };

    type UserResponse = {
      uuid: string;
      gamerTag: string;
      roles: string[];
    };

    type TokensWithUserResponse = TokensResponse & UserResponse;
  }

  type TileTypeData = {
    tileType: number;
    probabilities: { astralite: number; samarium: number; calamarite: number };
  };
}

export {};
