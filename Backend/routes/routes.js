const express = require("express");
const {
  createRoute,
  getAllRoutes,
  getFiltered,
  getRoute,
  editRoute,
} = require("../controllers/route");
const { errorHandler } = require("../utils/errorHandler");
const router = express.Router();

router.post("/", errorHandler(createRoute));
router.get("/", errorHandler(getAllRoutes));
router.get("/:startCity/:destination", errorHandler(getFiltered));
router.get("/:id", errorHandler(getRoute));
router.put("/:id", errorHandler(editRoute));

module.exports = router;
