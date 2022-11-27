const express = require("express");
const users = require("./routes/users");
const route = require("./routes/routes");
const mongoose = require("mongoose");
const auth = require("./routes/auth");
const buses = require("./routes/buses");
const busAssignment = require("./routes/busAssignments");
const booking = require("./routes/booking");
const price = require("./routes/price");
const dotenv = require("dotenv");
dotenv.config();
const app = express();

//mongoose setup
mongoose
  .connect("mongodb://localhost/mengedegna")
  .then(() => console.log("Connected to Mongodb ..."))
  .catch((err) => console.error("Couldn't connect to MongoDB", err));

// App Use
app.use(express.json());
app.use("/static", express.static("public"));
app.use("/api/users", users);
app.use("/api/routes", route);
app.use("/api/auth", auth);
app.use("/api/buses", buses);
app.use("/api/busAssignments", busAssignment);
app.use("/api/price", price);
app.use("/api/booking", booking);

app.use(function (err, req, res, next) {
  return res.status(500).send({ message: "Sth went wrong", error: err });
});

const port = process.env.PORT || 5000;

app.listen(port, console.log(`started listening on port ${port}`));
