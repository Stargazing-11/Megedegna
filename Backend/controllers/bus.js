const express = require("express");
const { Bus, findError } = require("../models/bus");
const _ = require("lodash");

exports.createBus = async function (req, res, next) {
  if (!findError(req.body)) {
    let bus = await Bus.findOne({
      number: req.body.number,
    });
    if (bus)
      return res.status(409).send({
        message: "bus exists, please edit the existing one",
        ...bus,
      });
    bus = new Bus(_.pick(req.body, ["number", "status", "structure", "route"]));
    bus = await bus.save();
    return res.status(201).send(bus);
  }

  return res.status(422).send({ message: "Validation error" });
};

exports.getAllBuses = async function (req, res, next) {
  const buses = await Bus.find();
  return res.send(buses);
};

exports.getBusesWithRoute = async function (req, res, next) {
  const buses = await Bus.find({ route: req.params.routeId });
  return res.send(buses);
};

exports.getBus = async function (req, res, next) {
  let bus = await Bus.findById(req.params.id);
  if (bus) return res.send(bus);
  return res.status(404).send({ message: "Some error" });
};

exports.editBus = async function (req, res, next) {
  if (!findError(req.body)) {
    let bus = await Bus.findById(req.params.id);
    if (!bus) return res.status(404).send({ message: "route does not exist" });

    bus.number = req.body.number;
    bus.status = req.body.status;
    bus.structure = req.body.structure;
    bus.route = req.body.route;

    bus = await bus.save();
    return res.status(201).send(bus);
  }
  return res.status(422).send({ message: "Validation error" });
};
