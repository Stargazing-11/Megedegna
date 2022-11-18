import express from 'express';
import Route from '../models/route.js'

export function createRoute(req) {
    const route = new Route({
        startCity: req.body.startCity,
        destination:req.body.destination,
        distance:req.body.distance
    });
    return route;
}

export async function getAllRoutes (){
    return await Route.find()
}

export async function getFiltered(req){
    console.log(req);
    return Route.find({startCity:req.body.startCity, destination:req.body.destination});
}

