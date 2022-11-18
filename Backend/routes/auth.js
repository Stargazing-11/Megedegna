import express from "express";
import mongoose from "mongoose";
import { User } from "../models/User.js";
import bcrypt from "bcrypt";
import Joi from "joi";
const router = express.Router();

router.post("/", async (req, res) => {
  const { error } = validate(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  let result = await User.findOne({ phone: req.body.phone });
  if (!result) return res.status(400).send("Invalid phone or phone. ");

  const validPassword = await bcrypt.compare(req.body.password, result.password);
  if(!validPassword) return res.status(400).send("Invalid phone or password. ");
  
  res.send(true);
});

export function validate(req) {

    const schema = Joi.object({
      phone: Joi.number().required(),
      password: Joi.string().required().min(8),
    });
    return schema.validate(req);

}
  

export default router;