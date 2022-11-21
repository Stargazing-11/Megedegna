const { getPrice,setPrice } = require("../utils/helper");

exports.getPrice = function(req,res, next){
    return {'Price': getPrice()}
}


exports.setPrice =function(req,res, next){
    const price = req.body.price
    if (!price || typeof price != 'number' || price<=0){
        return res.status(422).send({message: "Price is invalid"})
    }
    setPrice(price)
    return res.status(201).send("Successful")
}