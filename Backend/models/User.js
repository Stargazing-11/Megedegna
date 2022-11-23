const mongoose = require("mongoose");
const Joi = require("joi");
const jwt = require("jsonwebtoken");
const userSchema = mongoose.Schema({
  firstName: {
    type: String,
    max: 255,
    min: 6,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
  },
  phone: {
    type: String,
    min: 10,
    max: 10,
    required: true,
  },
  password: {
    type: String,
    required: true,
    min: 8,
    max: 1000,
  },
  role: {
    type: String,
    enum: ["Admin", "Passenger"],
    default: "Passenger",
  },
});

userSchema.methods.generateAuthToken = function () {
  const token = jwt.sign(
    {
      _id: this._id,
      firstName: this.firstName,
      lastName: this.lastName,
      phone: this.phone,
      role: this.role,
      email: this.email,
    },
    process.env.JWTPRIVATEKEY
  );
  return token;
};
const User = mongoose.model("User", userSchema);

exports.findError = function (userSchema) {
  const schema = Joi.object({
    firstName: Joi.string().min(3).max(255).required(),
    lastName: Joi.string().min(3).max(255).required(),
    email: Joi.string().email().required(),
    phone: Joi.string().min(10).max(10).required(),
    password: Joi.string().required().min(8),
    role: Joi.string().enum(["Admin", "Passenger"]),
  });
  let { error, value } = schema.validate(userSchema);
  return error;
};

exports.User = User;
