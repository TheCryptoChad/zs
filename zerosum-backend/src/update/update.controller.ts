import { Controller, Get } from '@nestjs/common';
import { UpdateService } from './update.service';
import { Update } from 'src/utils/typeorm/entities';

@Controller('update')
export class UpdateController {
  constructor(private readonly updateService: UpdateService) {}

  @Get('/get-all')
  async getAll(): Promise<Update[]> {
    try {
      return await this.updateService.getAll();
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  }
}
