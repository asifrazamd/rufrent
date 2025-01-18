const DatabaseService = require('../utils/service');
const AdminManager = require('../utils/admin'); 


class BaseController {
    constructor() {
      this.dbService = new DatabaseService();
      this.tableManager = new AdminManager(); 

    }
  
  }

  
  module.exports = BaseController;
  