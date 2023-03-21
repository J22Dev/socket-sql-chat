import argon from "argon2";
import { JWT_CONFIG } from "../config/config";
import jwt from "jsonwebtoken";

export const hashPass = (pass: string) => argon.hash(pass);
export const verifyPass = (hash: string, plain: string) =>
  argon.verify(hash, plain);

type TokenPayload = { sub: string } & Record<string, string>;
type TokenType = "ACCESS" | "REFRESH";
type SignTokenPayload = {
  type: TokenType;
  payload: TokenPayload;
};
type VerifyTokenPayload = {
  type: TokenType;
  payload: string;
};
export const signToken = ({ type, payload }: SignTokenPayload) => {
  const { secret, expiresIn } = JWT_CONFIG[type];
  return jwt.sign(payload, secret, { expiresIn });
};
export const signUserTokens = (p: TokenPayload) => {
  return {
    accessToken: signToken({ type: "ACCESS", payload: p }),
    refreshToken: signToken({ type: "REFRESH", payload: p }),
  };
};
export const verifyToken = ({
  type,
  payload,
}: VerifyTokenPayload): Promise<Error | TokenPayload> => {
  return new Promise((res, rej) => {
    const { secret } = JWT_CONFIG[type];
    jwt.verify(payload, secret, (err, decoded) => {
      if (err) rej(new Error("Token Not Valid"));
      res(decoded as TokenPayload);
    });
  });
};
