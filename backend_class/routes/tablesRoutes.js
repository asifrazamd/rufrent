/**
 * Routes for table-related operations.
 * This module defines API endpoints for interacting with tables.
 * 
 * - GET /api/getFmList: Fetches a list of FMs (Facility Managers) for a given community ID.
 * 
 * Controller: FMController
 * 
 * @module routes/tableRoutes
 */
const authenticate = require('../middleware/authenticate');
require('dotenv').config();


const express = require('express');
const { UserActionsController, PropertyController, FMController,TaskController,addNewRecord,getRecords,updateRecord,deleteRecord,addRmTask,updateTask,getPropertyAndRequestStats,getTopCommunities,ReportController,UserProfile,UserController} = require('../controllers/tableControllers');



// Initialize Express Router
const router = express.Router();

// Create an instance of FMController
const fmController = new FMController();
const propertyController=new PropertyController();
const actionsController=new UserActionsController();
const taskController=new TaskController();
const addNewRecordController=new addNewRecord();
const getRecordsController=new getRecords();
const updateRecordController=new updateRecord();
const deleteRecordController=new deleteRecord();
const assignRmToTransactionController=new addRmTask();
const updateTaskController=new updateTask();
const getPropertyAndRequestStatsController=new getPropertyAndRequestStats();
const getTopCommunitiesController=new getTopCommunities();
const generatePropertyReportController=new ReportController();
const userprofileController=new UserProfile();
const userController=new UserController();



/**
 * @route GET /api/getFmList
 * @description Fetches a list of FMs for a given community ID.
 * 
 * @param {string} community_id - The ID of the community for which FMs are to be fetched.
 * @returns {Object} 200 - A list of FM details with the corresponding community_id.
 * @returns {Object} 404 - Error message if no FMs are found for the provided community_id.
 * @returns {Object} 500 - Error message if an internal error occurs during the operation.
 * 
 * @example
 * // Request
 * GET /api/getFmList?community_id=1
 * 
 * // Response (200)
 * {
 *   "message": "Retrieved successfully.",
 *   "result": [
 *     {
 *       "fm_id": 5,
 *       "fm_name": "John Doe"
 *     },
 *     {
 *       "fm_id": 9,
 *       "fm_name": "Jane Smith"
 *     }
 *   ]
 * }
 * 
 * @example
 * // Response (404)
 * {
 *   "error": "No records found for the provided community_id."
 * }
 * 
 * @example
 * // Response (500)
 * {
 *   "error": "An error occurred while fetching FM status data.",
 *   "details": "Error details..."
 * }
 */
router.get('/getFmList', (req, res) => fmController.getFmList(req, res));

router.get('/showPropDetails',(req,res) => propertyController.showPropDetails(req,res));
router.get('/userpropdetails',(req,res) => propertyController.showPropDetails(req,res));

router.get('/usermylistings',(req,res) => propertyController.showPropDetails(req,res));

router.get('/actions',(req,res) => actionsController.getUserActions(req,res));
router.get('/usermyfavourties',authenticate,(req,res) => actionsController.getUserActions(req,res));

router.get('/fmdata',(req,res)=> taskController.getTasks(req,res));
router.get('/rmdata',(req,res)=> taskController.getTasks(req,res));
router.get('/admintransactions',(req,res)=> taskController.getTasks(req,res));


router.post('/addNewRecord',(req,res)=> addNewRecordController.addNewRecord(req,res));
router.post('/admin-managers-management',(req,res)=> addNewRecordController.addNewRecord(req,res));
router.post('/admin-communities',(req,res)=> addNewRecordController.addNewRecord(req,res));


router.get('/getRecords',(req,res)=> getRecordsController.getRecords(req,res));
router.get('/userprofile',(req,res)=> userprofileController.getUserProfile(req,res));

router.put('/updateRecord',(req,res)=> updateRecordController.updateRecord(req,res));
router.put('/admin-user-management',(req,res)=> updateRecordController.updateRecord(req,res));

router.delete('/deleteRecord',(req,res)=> deleteRecordController.deleteRecord(req,res));
router.post('/addRmTask',(req,res)=> assignRmToTransactionController.addRmTask(req,res));
router.put('/updateTask',(req,res)=> updateTaskController.updateTask(req,res));
router.get('/dasboardData',(req,res)=>getPropertyAndRequestStatsController.getPropertyAndRequestStats(req,res));
router.get('/getTopCommunities',(req,res)=> getTopCommunitiesController.getTopCommunities(req,res));
router.get('/admin-report-generation',(req,res)=> generatePropertyReportController.ReportController(req,res));
router.get('/roles',(req,res)=> userController.getUsersByRole(req,res));

// Export the router to be used in the main app
module.exports = router;
