import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('/api/v1');

  app.use(cookieParser());

  app.enableCors({
    origin:
      process.env.NODE_ENV === 'development'
        ? 'http://localhost:5173'
        : 'https://zerosum.moonsama.com',
    methods: ['GET', 'POST', 'PUT'],
    credentials: true,
  });

  await app.listen(process.env.PORT || 3000, '0.0.0.0');
}

bootstrap();
