const express = require("express");
const { Route, findError } = require("../models/route");
const { capitalize } = require("../utils/capitalize");
exports.createRoute = async function (req, res, next) {
  if (!findError(req.body)) {
    let route = await Route.findOne({
      startCity: req.body.startCity,
      destination: req.body.destination,
    });
    if (route)
      return res.status(409).send({
        message: "route existd, please edit the existing one",
        ...route,
      });
    route = new Route({
      startCity: req.body.startCity,
      destination: req.body.destination,
      distance: req.body.distance,
    });
    route = await route.save();
    return res.status(201).send(route);
  }
  return res.status(422).send({ message: "Validation error" });
};

exports.getAllRoutes = async function (req, res, next) {
  let route = await Route.find();
  return res.send(route);
};

async function findRouteIfExists(startCity, destination) {
  let route = await Route.find({
    startCity: capitalize(startCity),
    destination: capitalize(destination),
  });
  return route;
}
exports.findRouteIfExists = findRouteIfExists;

exports.getFiltered = async function (req, res, next) {
  let route = await findRouteIfExists(
    req.params.startCity,
    req.params.destination
  );
  return res.send(route);
};

exports.getRoute = async function (req, res, next) {
  let route = await Route.findById(req.params.id);
  if (route) return res.send(route);
  return res.status(404).send({ message: "Some error" });
};

exports.editRoute = async function (req, res, next) {
  if (!findError(req.body)) {
    let route = await Route.findById(req.params.id);
    if (!route)
      return res.status(404).send({ message: "route does not exist" });

    route.startCity = req.body.startCity;
    route.destination = req.body.destination;
    route.distance = req.body.distance;

    route = await route.save();
    return res.status(201).send(route);
  }
  return res.status(422).send({ message: "Validation error" });
};
