// paymentRoutes.js
const express = require("express");

const PaymentController = require("../controllers/paymentController");

const router = express.Router();

const paymentController = new PaymentController();

router.post("/create-order", (req, res) => paymentController.createOrder(req, res));
router.post("/verify-payment", (req, res) => paymentController.verifyPayment(req, res));

module.exports = router;