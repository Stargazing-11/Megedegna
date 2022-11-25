const { Booking, findError } = require("../models/booking");
const { BusAssignment } = require("../models/busAssignment");

exports.createBooking = async function (req, res, next) {
  let busAssigned = await BusAssignment.findById(req.body.busAssigned).populate(
    "bus"
  );
  if (!findError(req.body)) {
    let booking = Booking({
      user: req.user,
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      phoneNumber: req.body.phoneNumber,
      seat: req.body.seat,
      busAssigned: busAssigned._id,
    });
    booking = await booking.save();
    console.log(req.body, req.user, booking);
    return res.status(201).send(booking);
  }
  return res.status(422).send({ message: findError(req.body) });
};

exports.getAllBookingonDate = async function (req, res, next) {
  const busAssigned = await BusAssignment.findById(
    req.params.busAssignedId
  ).populate("bus");
  if (!busAssigned) {
    return res.status(404).send("Invalid parameter");
  }
  console.log(busAssigned);
  const bookings = await Booking.find({
    dateOfTravel: busAssigned.dateOfTravel,
    busAssigned: busAssigned._id,
  });
  return res.status(201).send(bookings);
};

exports.getBookingsForCurrentUser = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  return res.status(200).send(bookings);
};

exports.getPastBookings = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  // console.log(bookings)
  let pastBookings = [];
  for (var booking = 0; booking < bookings.length; booking++) {
    if (String(bookings[booking].busAssigned.dateOfTravel) < String(Date.now)) {
      pastBookings.push(bookings[booking]);
    }
  }
  return res.status(200).send(pastBookings);
};

exports.getFutureBookings = async function (req, res, next) {
  const bookings = await Booking.find({ user: req.user });
  let pastBookings = [];
  for (var booking = 0; booking < bookings.length; booking++) {
    if (String(bookings[booking].busAssigned.dateOfTravel) > String(Date.now)) {
      pastBookings.push(bookings[booking]);
    }
  }
  return res.status(200).send(pastBookings);
};
