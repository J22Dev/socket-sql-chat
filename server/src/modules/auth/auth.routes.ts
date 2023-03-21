import { Router } from "express";
import * as authService from "./auth.controller";

export const authRouter = Router();

authRouter
  .post("/register", authService.registerUserHandler)
  .post("/login", authService.loginUserHandler)
  .get("/refresh", authService.refreshUserHandler)
  .get("/signout", authService.signOutUserHandler);
