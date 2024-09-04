import { Controller, Get, Inject, Put, Req, Body, Param } from '@nestjs/common';
import { UserService } from './user.service';
import { Users } from 'src/utils/typeorm/entities';

// NOTE: User is accessible via 'request.user'
@Controller('user')
export class UserController {
  constructor(@Inject(UserService) private readonly userService: UserService) {}

  @Put('/register-address')
  async registerAddress(
    @Req() req: Express.Request,
    @Body() body,
  ): Promise<void> {
    try {
      await this.userService.registerAddress(
        req.user.uuid,
        body.address.toLowerCase(),
        body.message,
        body.signature,
      );
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Put('/add-pending-referral/:code')
  async addPendingReferral(@Param('code') code: string, @Req() req: Express.Request): Promise<void> {
    try {
      await this.userService.addPendingReferral(code, req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/get-user')
  async get(@Req() req: Express.Request): Promise<Users & {referralCode: string}> {
    try {
      return await this.userService.getUser(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/get-referral/:referral_code')
  async getReferral(@Param('referral_code') referralCode: string): Promise<{address: string, messageWithNonce: string, signedMessage: string}> {
    try {
      return await this.userService.getReferral(referralCode);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/use-faucet')
  async useFaucet(@Req() req: Express.Request): Promise<void> {
    try {
      await this.userService.useFaucet(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }

  @Get('/link-username')
  async linkUsername(@Req() req: Express.Request): Promise<void> {
    try {
      await this.userService.linkUsername(req.user.uuid);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
