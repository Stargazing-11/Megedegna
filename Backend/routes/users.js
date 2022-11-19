import express from "express";
import mongoose from "mongoose";
import { User, validate } from "../models/User.js";
import bcrypt from "bcrypt";
import _ from "lodash";
import jwt from "jsonwebtoken";
import config from "config";

const router = express.Router();

router.post("/register", async (req, res) => {
  const { error } = validate(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  let result = await User.findOne({ phone: req.body.phone });
  if (result) return res.status(400).send("User already registered");

  const salt = await bcrypt.genSalt(10);
  const hashed = await bcrypt.hash(req.body.password, salt);

  const user = new User(
    _.pick(req.body, ["firstName", "lastName", "email", "password", "phone"])
  );
  user.password = hashed;
  await user.save();

  const token = jwt.sign({ _id: user._id }, config.get("jwtPrivateKey"));

  res
    .header("x-auth-token", token)
    .send(_.pick(user, ["_id", "firstName", "lastName", "phone"]));
});

export default router;
