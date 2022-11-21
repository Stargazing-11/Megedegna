const { LocalStorage } = require("node-localstorage");

exports.getPrice = function () {
  const localStorage = new LocalStorage("./price");
  return localStorage.getItem("Price");
};

exports.setPrice = function (price) {
  const localStorage = new LocalStorage("./price");
  localStorage.setItem("Price", price);
};
