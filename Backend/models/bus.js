const mongoose = require("mongoose");
const Joi = require("joi");

const busSchema = mongoose.Schema({
  number: {
    type: Number,
    required: true,
    unique: true,
  },
  status: {
    type: Boolean,
    default: true,
  },
  route: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "Route",
  },
  structure: {
    type: Array,
    default: [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
    ],
  },
});

const Bus = mongoose.model("Bus", busSchema);

function findError(bus) {
  const schema = Joi.object({
    number: Joi.number().min(0).required(),
    status: Joi.boolean(),
    route: Joi.string().required(),
    structure: Joi.array(),
  });
  const { error, value } = schema.validate(bus);
  return error;
}

module.exports.Bus = Bus;
module.exports.findError = findError;
