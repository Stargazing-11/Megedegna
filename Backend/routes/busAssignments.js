const express = require("express");
const {
  createBusAssignemnt,
  getBusAssignment,
  checkIfBusIsAssigned,
} = require("../controllers/busAssignment");
const { errorHandler } = require("../utils/errorHandler");
const router = express.Router();

router.post("/", errorHandler(createBusAssignemnt));
router.get("/:id", errorHandler(getBusAssignment));
router.get(
  "/:startCity/:destination/:date",
  errorHandler(checkIfBusIsAssigned)
);

module.exports = router;
