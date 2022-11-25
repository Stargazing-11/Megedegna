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
const { auth } = require("../middlewares/auth");
const router = express.Router();

router.post("/", auth, errorHandler(createBooking));
router.get("/", auth, errorHandler(getBookingsForCurrentUser));
router.get("/onDate/:busAssignedId", errorHandler(getAllBookingonDate));
router.get("/future/",auth, errorHandler(getFutureBookings));
router.get("/past/", auth, errorHandler(getPastBookings));

module.exports = router;
