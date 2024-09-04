import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { verify } from 'jsonwebtoken';

@Injectable()
export class JwtMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    try {
      const { header, payload, signature } = req.cookies;

      const reconstructedToken = `${header}.${payload}.${signature}`;

      verify(reconstructedToken, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
          res.clearCookie('header');
          res.clearCookie('payload');
          res.clearCookie('signature');

          return res.status(401).json({ message: 'Invalid token' });
        }

        req.user = decoded as any;
        next();
      });
    } catch (error: any) {
      console.error(error);
      throw error;
    }
  }
}
