import express from "express";
import {createRoute, getAllRoutes, getFiltered} from "../controllers/route.js";

const router = express.Router();

router.post("/", async (req, res) => {
    try {
    const route = createRoute(req);
    const result = await route.save();
    res.status(201).send(result);
  } catch (err) {
    res.send(err.message);
  }
});

router.get("/", async (req, res) =>{
    try{
        const routes = await getAllRoutes();
        res.status(200).send(routes);
    } catch(err){
        res.send(err.message);
    }
})

router.post("/filtered", async (req, res)=>{
    try{
        const routes = await getFiltered(req);
        res.status(200).send(routes);
    }catch(err){
        res.status(400).send(err.message);
    }
})

export default router;
