import mongoose from "mongoose";
import Joi from "joi";

const userSchema = mongoose.Schema({
  // role: {
  //   type: String,
  //   enum: ["Admin", "Passenger", "Driver"],
  //   required: true,
  // },
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
});

export const User = mongoose.model("User", userSchema);

export function validate(userSchema) {
  const schema = Joi.object({
    firstName: Joi.string().min(3).max(255).required(),
    lastName: Joi.string().min(3).max(255).required(),
    email: Joi.string().email().required(),
    phone: Joi.string().min(10).max(10).required(),
    password: Joi.string().required().min(8),
  });

  return schema.validate(userSchema);
}
