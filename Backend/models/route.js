import mongoose from "mongoose";
import Joi from "joi";

const routeSchema = mongoose.Schema({
  startCity: {
    type: String,
    required: true,
  },
  destination: {
    type: String,
    required: true,
  },
  distance: {
    type: Number,
    required: true,
  },
});

const Route = mongoose.model("Route", routeSchema);

const schema = Joi.object({
  startCity: Joi.string().required(),
  destination: Joi.string().required(),
  distance: Joi.number().required(),
});
const { error, value } = schema.validate(routeSchema);

export default Route;
