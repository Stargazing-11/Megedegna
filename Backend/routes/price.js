const express = require("express");
const { getPrice, setPrice } = require("../controllers/price");
const router = express.Router();

router.post("/", getPrice);
router.get("/", setPrice);

module.exports = router;
