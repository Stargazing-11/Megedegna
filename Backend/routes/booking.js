const express = require("express");
const {
  createBooking,
  getAllBookingonDate,
  getBookingsForCurrentUser,
  getFutureBookings,
  getPastBookings,
  editBooking,
} = require("../controllers/booking");
const { errorHandler } = require("../utils/errorHandler");

const router = express.Router();

router.post("/", errorHandler(createBooking));
router.get("/", errorHandler(getBookingsForCurrentUser));
router.get("/:date", errorHandler(getAllBookingonDate));
router.get("/", errorHandler(getFutureBookings));
router.get("/", errorHandler(getPastBookings));
router.put("/:id", errorHandler(editBooking));

module.exports = router;
