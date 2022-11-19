const express = require("express");
const mongoose = require("mongoose");
const { User } = require("../models/User.js");
const bcrypt = require("bcrypt");
const Joi = require("joi");
const config = require("config");
const jwt = require("jsonwebtoken");
const router = express.Router();

router.post("/", async (req, res) => {
  const { error } = validate(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  let user = await User.findOne({ phone: req.body.phone });
  if (!user) return res.status(400).send("Invalid phone or phone. ");
  console.log(user);

  const validPassword = await bcrypt.compare(req.body.password, user.password);

  if (!validPassword)
    return res.status(400).send("Invalid phone or password. ");

  const token = jwt.sign({ _id: user._id }, process.env.JWTPRIVATEKEY);
  res.send(token);
});

function validate(req) {
  const schema = Joi.object({
    phone: Joi.number().required(),
    password: Joi.string().required().min(8),
  });
  return schema.validate(req);
}

module.exports = router;
