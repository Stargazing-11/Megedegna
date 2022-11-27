const { Booking, findError } = require("../models/booking");
const { BusAssignment } = require("../models/busAssignment");
const { getPrice } = require("../utils/helper");
const qrCode = require("qrcode");
const PDF = require("pdfkit");
const fs = require("fs");
const { reserveSeat } = require("./busAssignment");
const sendMail = require("../utils/mail");
const { User } = require("../models/User");

exports.createBooking = async function (req, res, next) {
  let busAssigned = await BusAssignment.findById(req.body.busAssigned)
    .populate("bus")
    .populate("route");
  const row = req.body.seat[0];
  const column = req.body.seat[1];

  if (busAssigned.occupied[row][column] == 1) {
    return res.status(401).send("This Seat is Already Taken");
  }
  if (!findError(req.body)) {
    let booking = Booking({
      user: req.user,
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      phoneNumber: req.body.phoneNumber,
      seat: req.body.seat,
      busAssigned: busAssigned._id,
    });

    let data = {
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      phoneNumber: req.body.phoneNumber,
      seat: req.body.seat,
      startCity: busAssigned.route.startCity,
      destination: busAssigned.route.destination,
      distance: busAssigned.route.distance,
    };
    const ok = await reserveSeat(busAssigned._id, row, column);
    if (!ok) throw Error("pb");
    booking = await booking.save();
    const img = await qrGenerator(data, busAssigned._id);
    await generatePdf(data, img, busAssigned._id);
    let user = await User.findById(req.user);
    if (user.email) {
      sendMail(
        "Ticket",
        user.email,
        `<a href=${process.env.BACKEND}static/${busAssigned._id}${data.seat[0]}${data.seat[1]}.pdf>link</a>`
      );
    }
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

const qrGenerator = async (data, busAssignedId) => {
  return new Promise((res, rej) => {
    qrCode.toFile(
      `public/${busAssignedId}${data.seat[0]}${data.seat[1]}.png`,
      JSON.stringify(data),
      (err, file) => {
        res(file);
      }
    );
  });
};
// function (err, file) {
//   if (err) return console.log(err);
//   return file;
// });

async function generatePdf(data, img, busAssignedId) {
  console.log("heree");
  const doc = new PDF();
  doc.pipe(
    fs.createWriteStream(
      `public/${busAssignedId}${data.seat[0]}${data.seat[1]}.pdf`
    )
  );

  doc.font("Times-Bold").fontSize(25).fillColor("blue");
  doc.text("Passenger Name: " + data.firstName + " " + data.lastName, {
    align: "center",
  });
  doc.text("Phone: " + data.phoneNumber, { align: "center" });
  doc.text("From: " + data.startCity, { align: "center" });
  doc.text("To: " + data.destination, { align: "center" });
  doc.text("Seat: " + data.seat, { align: "center" });
  doc.text("Total Distance: " + data.distance, {
    align: "center",
  });
  doc.text("Price: " + data.distance * getPrice(), {
    align: "center",
  });

  doc.image(`public/${busAssignedId}${data.seat[0]}${data.seat[1]}.png`, {
    fit: [200, 200],
    align: "right",
  });
  doc.end();
  return doc;
}
