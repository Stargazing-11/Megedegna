import mongoose from "mongoose";
import Joi from 'joi'

const userSchema = mongoose.Schema({
    role:{
        type:String,
        enum:["Admin", "Passenger", "Driver"],
        required:true
    },
    firstName:{
        type:String,
        max:255,
        min:6,
        required:true
    },
    lastName:{
        type:String,
        required:true
    },
    email:{
        type:String,
    },
    phone:{
        type:String,
        required:true
    },
    password:{
        type:String,
        required:true,
        min:8,
        max:1000
    }
})

const User = mongoose.model('User', userSchema);

const schema = Joi.object({
    firstName: Joi.string().min(3).max(255).required(),
    lastName: Joi.string().min(3).max(255).required(),
    email:Joi.string(),
    phone: Joi.number().required(),
    password:Joi.string().required().min(8)
});

const {error, value} = schema.validate(userSchema);

export default User