const { User, findError } = require("../models/User");
const bcrypt = require("bcrypt");
const _ = require("lodash");

exports.signup = async function (req, res) {
  if (findError(req.body))
    return res.status(422).send({ message: findError(req.body) });
  let result = await User.findOne({ phone: req.body.phone });
  if (result)
    return res.status(400).send({ message: "User already registered" });
  const salt = await bcrypt.genSalt(10);
  const hashed = await bcrypt.hash(req.body.password, salt);

  let user = new User(
    _.pick(req.body, ["firstName", "lastName", "email", "phone"])
  );
  user.password = hashed;
  user = await user.save();
  res
    .header("x-auth-token", user.generateAuthToken())
    .status(201).send(_.pick(user, ["_id", "firstName", "lastName", "phone", "role"]));
};
