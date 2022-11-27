const { Booking, findError } = require("../models/booking");
const { BusAssignment } = require("../models/busAssignment");
const { getPrice } = require("../utils/helper");
const qrCode = require("qrcode");
const PDF = require("pdfkit");
const nodemailer = require("nodemailer");
const fs = require("fs");

exports.createBooking = async function (req, res, next) {
  let busAssigned = await BusAssignment.findById(req.body.busAssigned)
    .populate("bus")
    .populate("route");
  if (busAssigned.occupied[req.body.seat[0][1]] == 1) {
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
    busAssigned[req.body.seat[0][1]] = 1;
    let data = {
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      phoneNumber: req.body.phoneNumber,
      seat: req.body.seat,
      startCity: busAssigned.route.startCity,
      destination: busAssigned.route.destination,
      distance: busAssigned.route.distance,
    };
    booking = await booking.save();
    console.log(booking.seat, await BusAssignment.findById(req.body.busAssigned))

    const img = await qrGenerator(data);
    setTimeout(async () => {
      await generatePdf(data, img);
    }, 1000);
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
  sendEmail();
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

async function qrGenerator(data) {
  let json = JSON.stringify(data);

  qrCode.toFile("qrCode.png", json, function (err, file) {
    if (err) return console.log(err);
    return file;
  });
}

async function generatePdf(data, img) {
  console.log("heree");
  const doc = new PDF();
  doc.pipe(fs.createWriteStream("Ticket.pdf"));

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

  doc.image("qrCode.png", {
    fit: [200, 200],
    align: "right",
  });
  doc.end();
  return doc;
}
