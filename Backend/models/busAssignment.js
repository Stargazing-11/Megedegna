const mongoose = require("mongoose");
const Joi = require("joi");

const busAssignmentSchema = mongoose.Schema({
  bus: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    rel: "Bus",
  },
  dateOfTravel: {
    type: Date,
    required: true,
  },
  occupied: {
    type: Array,
    required: true,
  },
  route: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: 'Route'
  },
});

const BusAssignment = mongoose.model("BusAssignment", busAssignmentSchema);

function findError(busAssignment) {
  const schema = Joi.object({
    bus: Joi.string().required(),
    dateOfTravel: Joi.date(),
    route: Joi.string(),
  });
  const { error, value } = schema.validate(busAssignment);
  return error;
}

module.exports.BusAssignment = BusAssignment;
module.exports.findError = findError;
