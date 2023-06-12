import jwt from 'jsonwebtoken';
import { JWT_SECRET } from '$env/static/private';

type User = {
  email: string;
  id: string;
};

export const verifyAndDecodeToken = (token: string) => {
  try {
    return jwt.verify(token, JWT_SECRET) as User;
  } catch (error) {
    return null;
  }
};
