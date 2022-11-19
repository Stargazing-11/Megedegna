const express = require("express");
const {
  createBus,
  getAllBuses,
  getBus,
  editBus,
  getBusesWithRoute,
} = require("../controllers/bus");
const { errorHandler } = require("../utils/errorHandler");
const router = express.Router();

router.post("/", errorHandler(createBus));
router.get("/", errorHandler(getAllBuses));
router.get("/:routeId", errorHandler(getBusesWithRoute));
router.get("/:id", errorHandler(getBus));
router.put("/:id", errorHandler(editBus));

module.exports = router;
