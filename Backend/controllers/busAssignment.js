const express = require("express");
const { BusAssignment, findError } = require("../models/busAssignment");
const { Bus } = require("../models/bus");
const _ = require("lodash");

exports.createBus = async function (req, res, next) {
  if (!findError(req.body)) {
    let bus = await Bus.findById(req.body.bus).populate("route");
    if (!bus) {
      return res.status(404).send({
        message: "bus does not exist",
      });
    }

    let busAssignment = BusAssignment({
      bus: bus._id,
      dateOfTravel: req.body.dateOfTravel,
      occupied: bus.structure,
      route: {
        startCity: bus.route.startCity,
        destination: bus.route.destination,
        distance: bus.route.distance,
      },
    });
    busAssignment = await busAssignment.save();
    return res.status(201).send(busAssignment);
  }
  return res.status(422).send({ message: "Validation error" });
};

exports.getBusAssignment = async function (req, res, next) {
  const bus = await BusAssignment.findById(req.params.id).populate("bus");
  return res.send(bus);
};

// exports.getBus = async function (req, res, next) {
//   let bus = await Bus.findById(req.params.id);
//   if (bus) return res.send(bus);
//   return res.status(404).send({ message: "Some error" });
// };

// exports.editBus = async function (req, res, next) {
//   if (!findError(req.body)) {
//     let bus = await Bus.findById(req.params.id);
//     if (!bus) return res.status(404).send({ message: "route does not exist" });

//     bus.number = req.body.number;
//     bus.status = req.body.status;
//     bus.structure = req.body.structure;
//     bus.route = req.body.route;

//     bus = await bus.save();
//     return res.status(201).send(bus);
//   }
//   return res.status(422).send({ message: "Validation error" });
// };
