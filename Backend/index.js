const express = require("express");
const users = require("./routes/users");
const route = require("./routes/routes");
const mongoose = require("mongoose");
const auth = require("./routes/auth");
const buses = require("./routes/buses");
const busAssignment = require("./routes/busAssignments");
const price = require("./routes/price");

const app = express();

//mongoose setup
mongoose
  .connect("mongodb://localhost/mengedegna")
  .then(() => console.log("Connected to Mongodb ..."))
  .catch((err) => console.error("Couldn't connect to MongoDB", err));

// App Use
app.use(express.json());
app.use("/api/user", users);
app.use("/api/routes", route);
app.use("/api/auth", auth);
app.use("/api/buses", buses);
app.use("/api/busAssignments", busAssignment);
app.use("/api/price", price);

app.use(function (err, req, res, next) {
  return res.status(500).send({ message: "Sth went wrong" });
});

const port = process.env.PORT || 5000;

app.listen(port, console.log(`started listening on port ${port}`));
