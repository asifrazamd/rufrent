const DatabaseService = require('../utils/service');
const AdminManager = require('../utils/admin'); 
const PaymentService= require('../utils/paymentService');


class BaseController {
    constructor() {
      this.dbService = new DatabaseService();
      this.tableManager = new AdminManager(); 
      this.paymentService= new PaymentService();

    }
  
  }

  
  module.exports = BaseController;
  