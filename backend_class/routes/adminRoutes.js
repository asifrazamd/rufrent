const authenticate = require('../middleware/authenticate');
require('dotenv').config();


const express = require('express');

const {AdminController,AdminDasboard}=require('../controllers/adminController')





// Initialize Express Router
const router = express.Router();
const adminController = new AdminController();
const adminDasboard = new AdminDasboard();




router.get('/st-tables', (req, res) => adminController.getTablesAndFields(req, res));
router.get('/admin-st-tables', (req, res) => adminController.getTablesAndFields(req, res));
router.get('/admin-dy-tables', (req, res) => adminController.getdyTablesAndFields(req, res));


router.get('/admindasboard', (req, res) => adminDasboard.AdminDasboard(req,res));




// Export the router to be used in the main app
module.exports = router;
