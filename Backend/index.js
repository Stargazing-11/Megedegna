import express from "express";
import users from "./routes/users.js";
import route from './routes/route.js';
import mongoose from 'mongoose';
import auth from "./routes/auth.js"

const app = express();

//mongoose setup
mongoose.connect('mongodb://localhost/mengedegna')
    .then(() => console.log('Connected to Mongodb ...'))
    .catch(err => console.error("Couldn't connect to MongoDB", err))


// App Use 
app.use(express.json())
app.use("/api/user", users);
app.use("/api/route/", route);
app.use("/api/auth", auth);

const port = process.env.PORT || 5000;

app.listen(port, console.log(`started listening on port ${port}`));
