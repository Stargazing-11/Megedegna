const { getPrice, setPrice: setPriceAlias } = require("../utils/helper");

exports.getPrice = function (req, res, next) {
  return res.send({ Price: getPrice() });
};

exports.setPrice = function (req, res, next) {
  console.log(req.body);
  const price = req.body.price;
  if (!price || typeof price != "number" || price <= 0) {
    return res.status(422).send({ message: "Price is invalid" });
  }
  setPriceAlias(price);
  return res.status(201).send("Successful");
};
