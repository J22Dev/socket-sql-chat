import dotenv from "dotenv";
dotenv.config();

export const JWT_CONFIG = {
  ACCESS: {
    secret: process.env.JWT_ACCESS_SECRET as string,
    expiresIn: "15m",
  },
  REFRESH: {
    secret: process.env.JWT_REFRESH_SECRET as string,
    expiresIn: "7d",
  },
};

export const APP_CONFIG = {
  PORT: parseInt(process.env.PORT as string),
  env: process.env.NODE_ENV as string,
};
