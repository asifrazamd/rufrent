
const AdminManager = require('../utils/admin'); // Adjust the path as needed
const DatabaseService = require('../utils/service'); // Correct import path
const db = require("../config/db"); // Database connection object
const { propertyFields, fieldNames1 } = require("../utils/joins");
const authenticate=require("../middleware/authenticate");
require('dotenv').config();
const BaseController = require("../utils/baseClass"); // Adjust the path as needed



class AdminController extends BaseController {



  
  async getTablesAndFields(req, res) {
    try {
      // Fetch tables and their fields using the TableManager instance
      const tablesWithFields = await this.tableManager.getTablesWithFields();

      const test1=await this.tableManager.getSTTables();

      // Check if no tables are found
      if (!tablesWithFields || tablesWithFields.length === 0) {
        return res.status(200).json({
          message: 'No tables found.',
          data: [],
        });
      }
          // Restructure the data to have table names as keys
    const structuredData = tablesWithFields.reduce((acc, { tableName, fields }) => {
      acc[tableName] = fields; // Use tableName as the key and fields as the value
      return acc;
    }, {});

      // Return the results in a successful response
      res.status(200).json({
        message: 'Tables and their fields retrieved successfully.',
        tables:test1,
        // data: tablesWithFields,
        data: structuredData,

      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error('Error fetching tables and fields:', error.message);
      res.status(500).json({
        error: 'An error occurred while fetching tables and fields.',
        details: error.message, // Provide the error details for debugging
      });
    }
  }
  async getdyTablesAndFields(req, res) {
    try {
      // Fetch tables and their fields using the TableManager instance
      const tablesWithFields = await this.tableManager.getDyTablesWithFields();

      const test1=await this.tableManager.getDYTables();

      // Check if no tables are found
      if (!tablesWithFields || tablesWithFields.length === 0) {
        return res.status(200).json({
          message: 'No tables found.',
          data: [],
        });
      }
          // Restructure the data to have table names as keys
    const structuredData = tablesWithFields.reduce((acc, { tableName, fields }) => {
      acc[tableName] = fields; // Use tableName as the key and fields as the value
      return acc;
    }, {});

      // Return the results in a successful response
      res.status(200).json({
        message: 'Tables and their fields retrieved successfully.',
        tables:test1,
        // data: tablesWithFields,
        data: structuredData,

      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error('Error fetching tables and fields:', error.message);
      res.status(500).json({
        error: 'An error occurred while fetching tables and fields.',
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class AdminDasboard extends BaseController {

  async AdminDasboard(req, res) {
    try {
      // Query for total properties (current_status = 3) using getAggregateValue
      const totalProperties = await this.dbService.getAggregateValue('dy_property', 'current_status', 'COUNT', "current_status = 3");
  
      // Query for pending properties (current_status = 1)
      const pendingProperties = await this.dbService.getAggregateValue('dy_property', 'current_status', 'COUNT', "current_status = 1");
  
       // Query for total requests (count of transactions)
      const totalRequests = await this.dbService.getAggregateValue('dy_transactions', 'id', 'COUNT',null);
  
       // Query for total communities (count of communities where rstatus = 1)
      const totalCommunities = await this.dbService.getAggregateValue('st_community', 'rstatus', 'COUNT', "rstatus = 1");
  
      // Return the results in the response
      res.status(200).json({
        message: 'Retrieved successfully.',
        result: {
          total_properties: totalProperties[0].result, // Adjusted to return 'result' from the procedure output
          pending_properties: pendingProperties[0].result, // Adjusted to return 'result' from the procedure output
          total_requests: totalRequests[0].result, // Adjusted to return 'result' from the procedure output
          total_communities: totalCommunities[0].result, // Adjusted to return 'result' from the procedure output
        },
      });
    } catch (error) {
      console.error('Error fetching property and request stats:', error.message);
      res.status(500).json({
        error: 'An error occurred while fetching the stats.',
        details: error.message, // Provide the error details for debugging
      });
    }
  }
  
}


module.exports = {AdminController,AdminDasboard};
