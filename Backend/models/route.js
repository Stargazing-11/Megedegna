const mongoose = require("mongoose");
const Joi = require("joi");
const { capitalize } = require("../utils/capitalize");
const routeSchema = mongoose.Schema({
  startCity: {
    type: String,
    required: true,
    set: capitalize,
  },
  destination: {
    type: String,
    required: true,
    set: capitalize,
  },
  distance: {
    type: Number,
    required: true,
    min: 0,
  },
});

const Route = mongoose.model("Route", routeSchema);

function findError(route) {
  const schema = Joi.object({
    startCity: Joi.string().required(),
    destination: Joi.string().required(),
    distance: Joi.number().min(0).required(),
  });
  const { error, value } = schema.validate(route);
  return error;
}

module.exports.Route = Route;
module.exports.findError = findError;
