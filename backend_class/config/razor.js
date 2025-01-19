const dotenv = require('dotenv');
dotenv.config();
const Razorpay = require("razorpay");

 const razorpay = new Razorpay({
    key_secret: process.env.RAZOR_KEY_SECRET, // Replace with your Razorpay Key ID
    key_id: process.env.RAZOR_KEY_ID, // Replace with your Razorpay Key Secret
  });
  
module.exports =razorpay