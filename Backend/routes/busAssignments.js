const express = require("express");
const {
  createBus,
  getBusAssignment,
  checkIfBusIsAssigned,
} = require("../controllers/busAssignment");
const { errorHandler } = require("../utils/errorHandler");
const router = express.Router();

router.post("/", errorHandler(createBus));
router.get("/:id", errorHandler(getBusAssignment));
router.get("/:startCity/:destination/:date", errorHandler(checkIfBusIsAssigned));

module.exports = router;
