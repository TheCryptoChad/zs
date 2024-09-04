import { Controller, Get, Inject, Param, Post, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Response } from 'express';

@Controller('auth')
export class AuthController {
  constructor(@Inject(AuthService) private readonly authService: AuthService) {}

  @Post('/getToken/:code')
  getToken(@Param('code') code, @Res({ passthrough: true }) res: Response) {
    try {
      return this.authService.getToken(code, res);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Post('/refreshToken/:refreshToken')
  refreshToken(@Param('refreshToken') refreshToken) {
    try {
      return this.authService.refreshToken(refreshToken);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/logout')
  logout(@Res() res: Response) {
    try {
      return this.authService.logout(res);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
