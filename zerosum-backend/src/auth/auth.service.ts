import { Injectable, Res } from '@nestjs/common';
import { Response } from 'express';
import { HttpService } from '@nestjs/axios';
import { lastValueFrom, map } from 'rxjs';
import { UserService } from '../user/user.service';
import { sign } from 'jsonwebtoken';

@Injectable()
export class AuthService {
  constructor(
    private readonly httpService: HttpService,
    private userService: UserService,
  ) {}

  async getToken(code: string, res: Response) {
    try {
      const { access_token } = await this._getPortalTokens(code);
      const { uuid, gamerTag } = await this._getPortalUser(access_token);

      // Update the user access token in the repository
      await this.userService.handleSignIn(uuid, access_token, gamerTag);

      res = this._addSignedJWT(uuid, res);

      const user = await this.userService.getUser(uuid);

      res.json({ user });
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }

  refreshToken(refreshToken: string): any {
    try {
      const data = {
        refreshToken,
        grant_type: 'refresh_token',
        client_id: process.env.BRIDGE_APP_ID,
        client_secret: process.env.BRIDGE_SECRET,
        redirect_uri: process.env.FRONTEND_CALLBACK_URL,
      };
      return this.httpService
        .post(`${process.env.BRIDGE_API_URL}/oauth2/token`, data)
        .pipe(
          map((response) => {
            return response.data;
          }),
        );
    } catch (error: any) {
      console.log(error.message);
      throw error;
    }
  }

  logout(res: Response) {
    try {
      res.clearCookie('header', {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      res.clearCookie('payload', {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: false, // Making this available to JavaScript
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      res.clearCookie('signature', {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      return res.status(200).send();
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private _addSignedJWT(uuid: string, @Res() res: Response) {
    try {
      const token = sign({ uuid: uuid }, process.env.JWT_SECRET, {
        expiresIn: '3h',
      });

      const [header, payload, signature] = token.split('.');

      res.cookie('header', header, {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      res.cookie('payload', payload, {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: false, // Making this available to JavaScript
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      res.cookie('signature', signature, {
        domain:
          process.env.NODE_ENV === 'development'
            ? 'localhost'
            : '.moonsama.com',
        httpOnly: true,
        sameSite: 'none',
        secure: true,
        path: '/',
      });

      return res;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private async _getPortalTokens(
    code: string,
  ): Promise<Moonsama.TokensResponse> {
    try {
      const data = {
        code,
        grant_type: 'authorization_code',
        client_id: process.env.BRIDGE_APP_ID,
        client_secret: process.env.BRIDGE_SECRET,
        redirect_uri: process.env.FRONTEND_CALLBACK_URL,
      };

      const tokensRequest = this.httpService
        .post(`${process.env.BRIDGE_API_URL}/oauth2/token`, data)
        .pipe(
          map((response) => {
            return response.data;
          }),
        );

      const tokensResponse: Moonsama.TokensResponse = await lastValueFrom(
        tokensRequest,
      );

      return tokensResponse;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  private async _getPortalUser(
    accessToken: string,
  ): Promise<Moonsama.UserResponse> {
    try {
      const userRequest = this.httpService
        .get(`${process.env.BRIDGE_API_URL}/oauth2/resource/user`, {
          headers: {
            Authorization: `Bearer ${accessToken}`,
          },
        })
        .pipe(
          map((response) => {
            return response.data;
          }),
        );

      const userResponse: Moonsama.UserResponse = await lastValueFrom(
        userRequest,
      );

      return userResponse;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
