const { Booking, findError } = require("../models/booking");
const { BusAssignment } = require("../models/busAssignment");

exports.createBooking = async function (req, res, next) {
  let busAssigned = await BusAssignment.findById(req.body.busAssigned).populate(
    "BusAssigned"
  );
  if (!findError(req.body)) {
    let booking = Booking({
      user: req.user,
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      phone: req.body.phone,
      seat: req.body.seat,
      dateOfTravel: req.body.dateOfTravel,
      busAssigned: busAssigned._id,
    });
    booking = await booking.save();
    return res.status(201).send(book);
  }
};

exports.getAllBookingonDate = async function (req, res, next) {
  const bookings = await Booking.find({
    dateOfTravel: req.body.dateOfTravel,
    busAssigned: req.body.busAssigned,
  });
  return bookings;
};

exports.getBookingsForCurrentUser = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  return bookings;
};

exports.getPastBookings = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  let pastBookings = [];
  for (var booking = 0; booking < bookings.length(); booking++) {
    if (String(bookings[booking].dateOfTravel) < String(Date.now)) {
      pastBookings.push(bookings[booking]);
    }
  }
  return pastBookings;
};

exports.getFutureBookings = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  let pastBookings = [];
  for (var booking = 0; booking < bookings.length(); booking++) {
    if (String(bookings[booking].dateOfTravel) > String(Date.now)) {
      pastBookings.push(bookings[booking]);
    }
  }
  return pastBookings;
};
