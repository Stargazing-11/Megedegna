const express = require("express");
const { User } = require("../models/User.js");
const bcrypt = require("bcrypt");
const Joi = require("joi");
const router = express.Router();
const _ = require("lodash");

router.post("/", async (req, res) => {
  if (findError(req.body))
    return res.status(422).send({ message: "Validation error" });

  let user = await User.findOne({ phone: req.body.phone });
  if (!user) return res.status(400).send("Invalid phone or password. ");

  const validPassword = await bcrypt.compare(req.body.password, user.password);

  if (!validPassword)
    return res.status(400).send("Invalid phone or password. ");
  res
    .header("x-auth-token", user.generateAuthToken())
    .send(_.pick(user, ["_id", "firstName", "lastName", "phone", "role"]));
});

function findError(req) {
  const schema = Joi.object({
    phone: Joi.string().min(10).max(10).required(),
    password: Joi.string().required().min(8),
  });
  let { error } = schema.validate(req);
  return error;
}

module.exports = router;
