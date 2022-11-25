const mongoose = require("mongoose");
const Joi = require("joi");

const schema = mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  firstName: {
    type: String,
    required: true,
    min: 3,
    max: 255,
  },
  lastName: {
    type: String,
    required: true,
    min: 3,
    max: 255,
  },
  phoneNumber: {
    type: String,
    required: true,
    min: 10,
    max: 10,
  },
  seat: {
    type: String,
    required: true,
  },
  busAssigned: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "BusAssignment",
  },
});

const Booking = mongoose.model("Booking", schema);

function findError(busAssignment) {
  const schema = Joi.object({
    firstName: Joi.string().min(3).max(255).required(),
    lastName: Joi.string().min(3).max(255).required(),
    seat: Joi.string().required(),
    phoneNumber:Joi.string().required(),
    busAssigned:Joi.string().required()
  });
  const { error, value } = schema.validate(busAssignment);
  return error;
}

module.exports.Booking = Booking;
module.exports.findError = findError;
