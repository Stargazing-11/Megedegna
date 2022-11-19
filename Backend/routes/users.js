const express = require("express");
const mongoose = require("mongoose");
const { User, validate } = require("../models/User.js");
const bcrypt = require("bcrypt");
const _ = require("lodash");

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
  await user.save();
  res.send(_.pick(user, ["_id", "firstName", "lastName", "phone"]));
});

module.exports = router;
