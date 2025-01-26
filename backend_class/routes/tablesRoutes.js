const authenticate = require('../middleware/authenticate');
require('dotenv').config();


const express = require('express');
const { UserActionsController, PropertyController, FMController,TaskController,addNewRecord,getRecords,updateRecord,deleteRecord,addRmTask,updateTask,getPropertyAndRequestStats,getTopCommunities,UserProfile,UserController,  LandMarksController,
    CityBasedCommunitiesController,AmenitiesController,AddCommunitiesController
  } = require('../controllers/tableControllers');



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
const userprofileController=new UserProfile();
const userController=new UserController();
const landmarksController=new LandMarksController();
const cityBasedCommunitiesController=new CityBasedCommunitiesController();
const allAmenitiesController=new AmenitiesController();
const addCommunitiesController=new AddCommunitiesController();






router.get('/getFmList', (req, res) => fmController.getFmList(req, res));

router.get('/showPropDetails',(req,res) => propertyController.showPropDetails(req,res));
router.get('/userpropdetails',(req,res) => propertyController.showPropDetails(req,res));

router.get('/usermylistings',(req,res) => propertyController.showPropDetails(req,res));

router.get('/actions',(req,res) => actionsController.getUserActions(req,res));
router.get('/usermyfavourties',(req,res) => actionsController.getUserActions(req,res));

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
router.get('/roles',(req,res)=> userController.getUsersByRole(req,res));
router.get('/landmarks',(req,res)=>landmarksController.landMarks(req,res));
router.get('/CityBasedCommunities',(req,res)=> cityBasedCommunitiesController.CityBasedCommunities(req,res));
router.post('/addcommunities',(req,res)=>addCommunitiesController.addcommunities(req,res));

router.get("/amenities", (req, res) => {
  allAmenitiesController.getAmenities(req, res);
});
router.post("/addamenities", (req, res) => {
  allAmenitiesController.addAmenities(req, res);
});




// Export the router to be used in the main app
module.exports = router;
