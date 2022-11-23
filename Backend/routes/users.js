const express = require("express");
const { signup } = require("../controllers/user");
const { errorHandler } = require("../utils/errorHandler");
const router = express.Router();

router.post("/", errorHandler(signup));

module.exports = router;
