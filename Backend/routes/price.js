const express = require("express");
const { getPrice, setPrice } = require("../controllers/price");
const router = express.Router();

router.post("/", setPrice);
router.get("/", getPrice);

module.exports = router;
