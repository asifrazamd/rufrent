// paymentController.js
const BaseController = require("../utils/baseClass");
const PaymentService = require("../utils/paymentService");

class PaymentController extends BaseController {


async createOrder(req, res) {
  try {
      const { amount, currency } = req.body;
      const receipt = "receipt_" + new Date().getTime();

      const order = await this.paymentService.createOrder({ amount, currency, receipt });
      console.log("Order created controller", order);
      res.json({ success: true, order });
  } catch (error) {
      res.status(500).json({ success: false, message: "Order creation failed", error: error.message });
  }
}

async verifyPayment(req, res) {
  try {
      const { razorpay_payment_id, razorpay_order_id, user_id, property_id  } = req.body;

      const result = await this.paymentService.verifyPayment({ razorpay_payment_id, razorpay_order_id ,user_id, property_id  });
      console.log("payment verfied controller",result);
      if (result.success) {
          res.json(result);
      } else {
          res.status(400).json(result);
      }
  } catch (error) {
      res.status(500).json({ success: false, message: "Verification failed", error: error.message });
  }
}

}
module.exports = PaymentController;