const {
  BusAssignment,
  findError: findErrorAlias,
} = require("../models/busAssignment");
const { Bus } = require("../models/bus");
const { Route } = require("../models/route");
const { findRouteIfExists } = require("./route");
const { getPrice } = require("../utils/helper");

const _ = require("lodash");
const Joi = require("joi");

function findError(travelInfo) {
  const schema = Joi.object({
    startCity: Joi.string().required(),
    destination: Joi.string().required(),
    date: Joi.date(),
  });
  const { error, value } = schema.validate(travelInfo);
  return error;
}

exports.createBus = async function (req, res, next) {
  if (!findErrorAlias(req.body)) {
    let bus = await Bus.findById(req.body.bus).populate("route");
    let route = await Route.findById(req.body.route);
    if (!bus || !route) {
      return res.status(404).send({
        message: "bus or route does not exist",
      });
    }

    let busAssignment = BusAssignment({
      bus: bus._id,
      dateOfTravel: req.body.dateOfTravel,
      occupied: bus.structure,
      route: route._id,
    });
    busAssignment = await busAssignment.save();
    return res.status(201).send(busAssignment);
  }
  return res.status(422).send({ message: findErrorAlias(req.body) });
};

exports.getBusAssignment = async function (req, res, next) {
  const busAssignment = await BusAssignment.findById(req.params.id).populate(
    "bus"
  );
  return res.send(bus);
};

exports.checkIfBusIsAssigned = async function (req, res, next) {
  if (findError(req.params))
    return res.status(422).send({ message: "Validation error" });
  if (String(Date.now()) > String(req.body.date))
    return res.status(422).send({ message: "The date is incorrect" });
  const route = await findRouteIfExists(
    req.params.startCity,
    req.params.destination
  );
  if (!route) {
    return res.status(404).send({ message: "Route does not exist" });
  }
  const busAssignment = await BusAssignment.findOne({
    dateOfTravel: new Date(req.params.date),
    route: route,
  }).populate("route");
  if (!busAssignment)
    return res.status(404).send({ message: "No Bus is assigned" });
  return {
    busAssignment,
    totalPrice: busAssignment.route.distance * getPrice(),
  };
};
