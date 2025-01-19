const DatabaseService = require("../utils/service"); // Correct import path
const db = require("../config/db"); // Database connection object
const { propertyFields, fieldNames1 } = require("../utils/joins");
const authenticate = require("../middleware/authenticate");
require("dotenv").config();
const BaseController = require("../utils/baseClass"); // Adjust the path as needed

class FMController extends BaseController {

  /**
   * Fetches FM (Facility Manager) list for a given community ID.
   * This method retrieves a list of Facility Managers (FMs) for a specific community by joining the 'dy_rm_fm_com_map' and 'dy_user' tables.
   * It returns the list of FMs associated with the provided community ID.
   *
   * @param {Object} req - Express request object containing the query parameters.
   *        The community_id is extracted from `req.query` to filter the results.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: GET /api/getFmList?community_id=1
   * // Example response: { message: "Retrieved successfully.", result: [...] }
   */
  async getFmList(req, res) {
    const { community_id } = req.query; // Extract community_id from query parameters

    try {
      // Define the main table and its alias for the query
      const tableName = `dy_rm_fm_com_map r`; // Main table alias

      // Define the JOIN clauses to link the main table with other tables
      const joinClauses = `LEFT JOIN dy_user u ON r.fm_id = u.id
      LEFT JOIN dy_user u2 ON r.rm_id = u2.id
            LEFT JOIN st_community c ON r.community_id = c.id
`; 
      // Define the fields to select from the database
      const fieldNames = `r.fm_id, u.user_name AS fm_name,
            r.rm_id, u2.user_name AS rm_name,
                  r.community_id, c.name AS community_name

`;  

      // If community_id is provided, escape it to prevent SQL injection
      const whereCondition = community_id
        ? `r.community_id = ${db.escape(community_id)}` // Escape community_id to avoid SQL injection
        : "";

      // Fetch the data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      // Check if no records are found
      if (!results || results.length === 0) {
        return res
          .status(404)
          .json({ error: "No records found for the provided community_id." });
      }

      // Return the results in a successful response
      res.status(200).json({
        message: "Retrieved successfully.",
        result: results, // List of Facility Managers for the given community_id
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching FM status data:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching FM status data.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class PropertyController extends BaseController {

  /**
   * Fetches property details based on the provided filters and pagination parameters.
   *
   * @param {Object} req - Express request object containing query parameters.
   * @param {Object} res - Express response object used to send back the response.
   *
   * @returns {Promise<void>} - Sends a response with property details or an error message.
   */



  async showPropDetails(req, res) {
    try {
      const {
        user_id,
        property_id,
        current_status,
        city,
        builders,
        community,
        hometype,
        propertydescription,
        page = 1,
        limit = 6,
      } = req.query;
  
      const sanitizedPage = Math.max(1, parseInt(page, 10));
      const sanitizedLimit = Math.max(1, parseInt(limit, 10));
      const offset = (sanitizedPage - 1) * sanitizedLimit;
  
      const tableName = "dy_property dy";
      const joinClauses = `
        ${propertyFields}
      `;
      const fieldNames = fieldNames1;
  
      const whereClauses = [];
  
      if (user_id) whereClauses.push(`dy.user_id = ${db.escape(user_id)}`);
      if (property_id) whereClauses.push(`dy.id = ${db.escape(property_id)}`);
      if (current_status)
        whereClauses.push(`dy.current_status = ${db.escape(current_status)}`);
  
      if (city) {
        const cityArray = city.split(",").map((c) => c.trim());
        const escapedCities = cityArray.map((c) => db.escape(c)).join(", ");
        whereClauses.push(`dy.city IN (${escapedCities})`);
      }
      if (builders) {
        const buildersArray = builders.split(",").map((b) => b.trim());
        const escapedBuilders = buildersArray.map((b) => db.escape(b)).join(", ");
        whereClauses.push(`db.id IN (${escapedBuilders})`);
      }
      if (community) {
        const communityArray = community.split(",").map((c) => c.trim());
        const escapedCommunities = communityArray
          .map((c) => db.escape(c))
          .join(", ");
        whereClauses.push(`dc.id IN (${escapedCommunities})`);
      }
      if (hometype) {
        const hometypeArray = hometype.split(",").map((h) => h.trim());
        const escapedHometypes = hometypeArray
          .map((h) => db.escape(h))
          .join(", ");
        whereClauses.push(`dht.id IN (${escapedHometypes})`);
      }
      if (propertydescription) {
        const propertyDescArray = propertydescription
          .split(",")
          .map((d) => d.trim());
        const escapedDescs = propertyDescArray.map((d) => db.escape(d)).join(", ");
        whereClauses.push(`dpd.id IN (${escapedDescs})`);
      }
  
      const whereCondition =
        whereClauses.length > 0 ? whereClauses.join(" AND ") : "1";
  
      // Fetch property data
      const properties = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );
  
      const paginatedProperties = properties.slice(
        offset,
        offset + sanitizedLimit
      );
      const totalRecords = properties.length;
      const totalPages = Math.ceil(totalRecords / sanitizedLimit);
  
      if (paginatedProperties.length === 0) {
        return res.status(404).json({
          error: "No properties found for the given filters or page.",
        });
      }
  
      // Extract community IDs from properties
      const communityIds = paginatedProperties.map((p) => p.community_id);
      const uniqueCommunityIds = [...new Set(communityIds)];
  
      // Fetch landmarks for the extracted community IDs
      const landmarksTable = `dy_landmarks dl`;
      const landmarksJoinClauses = `
        LEFT JOIN st_landmarks_category slc ON dl.landmark_category_id = slc.id
      `;
      const landmarksFieldNames = `
        dl.community_id,
        dl.landmark_name,
        dl.distance,
        dl.landmark_category_id,
        slc.landmark_category
      `;
      const landmarksWhereCondition =
        uniqueCommunityIds.length > 0
          ? `dl.community_id IN (${uniqueCommunityIds.map((id) =>
              db.escape(id)
            )})`
          : "1";
  
      const landmarks = await this.dbService.getJoinedData(
        landmarksTable,
        landmarksJoinClauses,
        landmarksFieldNames,
        landmarksWhereCondition
      );
  
      // Organize landmarks by community ID
      const landmarksByCommunity = landmarks.reduce((acc, landmark) => {
        if (!acc[landmark.community_id]) {
          acc[landmark.community_id] = [];
        }
        acc[landmark.community_id].push(landmark);
        return acc;
      }, {});
  
      // Remove duplicates and enhance properties
      const enhancedProperties = paginatedProperties.reduce((acc, property) => {
        if (!acc.some((p) => p.id === property.id)) {
          const address = property.address || "";
          const pincodeMatch = address.match(/\b\d{6}\b/);
          const pincode = pincodeMatch ? pincodeMatch[0] : null;
          const pincodeUrl = pincode
            ? `https://api.postalpincode.in/pincode/${pincode}`
            : null;
  
          acc.push({
            ...property,
            pincode,
            pincode_url: pincodeUrl,
            landmarks: landmarksByCommunity[property.community_id] || [],
          });
        }
        return acc;
      }, []);
  
      res.status(200).json({
        message: "Property and landmarks fetched successfully.",
        pagination: {
          currentPage: sanitizedPage,
          totalPages,
          totalRecords,
          limit: sanitizedLimit,
        },
        properties: enhancedProperties,
      });
    } catch (error) {
      console.error("Error fetching property and landmark details:", error);
      res.status(500).json({
        error: "An error occurred while fetching property and landmark details.",
        details: error.message,
      });
    }
  }
  
  
}

class UserActionsController extends BaseController {

  /**
   * Fetches user actions based on provided filters.
   *
   * @param {Object} req - Express request object containing query parameters.
   * @param {Object} res - Express response object used to send back the response.
   *
   * @returns {Promise<void>} - Sends a response with user action details or an error message.
   */
  async getUserActions(req, res) {
    try {
      const { user_id, property_id, id } = req.query;

      // Define the main table and joins
      const tableName = "dy_user_actions ua";
      const joinClauses = `
LEFT JOIN 
    dy_user u ON ua.user_id = u.id
LEFT JOIN 
    dy_property dy ON ua.property_id = dy.id

    ${propertyFields}
LEFT JOIN 
    st_current_status scd ON ua.status_code = scd.id
      `;

      // Define the fields to retrieve
      const fieldNames = `
          ua.id AS action_id,
    scd.status_code AS status_description,
    scd.id as status_code_id,
    ${fieldNames1}
      `;

      // Build dynamic WHERE clause
      const whereClauses = [];
      if (id) whereClauses.push(`ua.status_code = ${db.escape(id)}`);
      if (user_id) whereClauses.push(`ua.user_id = ${db.escape(user_id)}`);
      if (property_id)
        whereClauses.push(`ua.property_id = ${db.escape(property_id)}`);

      const whereCondition =
        whereClauses.length > 0 ? whereClauses.join(" AND ") : "1";

      // Fetch data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      // Check if results are empty
      if (!results || results.length === 0) {
        return res.status(404).json({
          error: "No user actions found for the provided filters.",
        });
      }
      // Fetch matching properties for the given user_id
let userProperties = [];
if (user_id) {
  const mainTable = "dy_transactions dt";
  const joinClauses = `
    LEFT JOIN dy_user_actions dua ON dua.user_id = dt.user_id
    LEFT JOIN dy_user u ON dt.rm_id = u.id
  `;
  const fields = "dt.prop_id,u.user_name,u.mobile_no";
  const whereClause = `dua.user_id = ${db.escape(user_id)}`;

  // Fetch data using getJoinedData
  userProperties = await this.dbService.getJoinedData(
    mainTable,
    joinClauses,
    fields,
    whereClause
  );
      // Extract distinct property IDs along with user_name
  const uniqueProperties = [];
  const seenProps = new Set();

  userProperties.forEach((item) => {
    if (!seenProps.has(item.prop_id)) {
      seenProps.add(item.prop_id);
      uniqueProperties.push({
        prop_id: item.prop_id,
        user_name: item.user_name,
        RM_mobile_no:item.mobile_no
      });
    }
  });

  userProperties = uniqueProperties;


}


      // Send the response with results
      res.status(200).json({
        message: "User actions retrieved successfully.",
        results,
        userProperties
      });
    } catch (error) {
      console.error("Error fetching user actions:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching user actions.",
        details: error.message,
      });
    }
  }
}

class TaskController extends BaseController {

  /**
   * Retrieves tasks based on RM or FM ID.
   *
   * @param {Object} req - Express request object.
   * @param {Object} res - Express response object.
   * @returns {Promise<void>} - Sends response with task data or error message.
   */

  async getTasks(req, res) {
    try {
      const { rm_id, fm_id, community_id } = req.query;

      // Fetch main task data
      const mainTable = "dy_transactions dt";
      const joinClauses = `
        LEFT JOIN dy_user u1 ON dt.user_id = u1.id
        LEFT JOIN dy_property p ON dt.prop_id = p.id
        LEFT JOIN dy_user u2 ON p.user_id = u2.id
        LEFT JOIN st_community c ON p.community_id = c.id
        LEFT JOIN st_current_status cs ON dt.cur_stat_code = cs.id
        LEFT JOIN dy_user rm_user ON dt.rm_id = rm_user.id
        LEFT JOIN dy_user fm_user ON dt.fm_id = fm_user.id

      `;
      const fields = `
        dt.id AS transaction_id,
        c.id AS community_id,
        c.name AS community_name,
        u2.user_name AS owner_name,
        u2.mobile_no AS owner_mobile,
        u1.user_name AS tenant_name,
        u1.mobile_no AS tenant_mobile,
        dt.cur_stat_code AS curr_stat_code_id,
        cs.status_code AS curr_stat_code,
        dt.schedule_date AS schedule_date,
        dt.schedule_time AS schedule_time,
        dt.rm_id As rm_id,
        rm_user.user_name AS rm_name,
        dt.fm_id As fm_id,
        fm_user.user_name AS fm_name

      `;
      const conditions = [];
      if (rm_id) conditions.push(`rm_id = ${db.escape(rm_id)}`);
      if (fm_id) conditions.push(`fm_id = ${db.escape(fm_id)}`);
      if (community_id) conditions.push(`c.id = ${db.escape(community_id)}`);

      const whereCondition =
        conditions.length > 0 ? conditions.join(" AND ") : "1 = 1";

      const taskResults = await this.dbService.getJoinedData(
        mainTable,
        joinClauses,
        fields,
        whereCondition
      );

      if (!taskResults || taskResults.length === 0) {
        return res
          .status(404)
          .json({ error: "No records found for the provided parameters." });
      }

      // Fetch status data
      const statusCondition = rm_id
        ? 'status_category="RMA" OR status_category="FMA"'
        : fm_id
        ? 'status_category="FMA"'
        : "1 = 1"; // Fetch all statuses if no IDs are provided

      const statusResults = await this.dbService.getRecordsByFields(
        "st_current_status",
        "id, status_code",
        statusCondition
      );

      // If rm_id is provided, fetch associated properties
      let associatedProperties = [];
      if (rm_id) {
        const communityResults = await this.dbService.getRecordsByFields(
          "dy_rm_fm_com_map",
          "community_id",
          `rm_id = ${db.escape(rm_id)}`
        );

        const communityIds = communityResults.map((row) => row.community_id);

        if (communityIds.length > 0) {
          const propertyTable = "dy_property dy";
          const propertyJoinClauses = `
            LEFT JOIN dy_user u1 ON dy.user_id = u1.id
            LEFT JOIN dy_transactions dt ON dy.id = dt.prop_id
            LEFT JOIN dy_user u2 ON dt.user_id = u2.id
          `;
          const propertyFields = `
            dy.id AS property_id,
            dy.community_id,
            u1.user_name AS owner_name,
            u1.mobile_no AS owner_mobile,
            u2.user_name AS tenant_name,
            u2.mobile_no AS tenant_mobile
          `;
          const propertyCondition = `community_id IN (${communityIds.join(
            ", "
          )})`;

          associatedProperties = await this.dbService.getJoinedData(
            propertyTable,
            propertyJoinClauses,
            propertyFields,
            propertyCondition
          );
        }
      }

      // Send response
      return res.status(200).json({
        message: "Data retrieved successfully.",
        result: taskResults,
        status: statusResults,
        associatedProperties: associatedProperties,
      });
    } catch (error) {
      console.error("Error in getTasks:", error);
      res.status(500).json({
        error: "An error occurred while retrieving task data.",
        details: error.message,
      });
    }
  }
}

class updateTask extends BaseController {

  /**
   * Updates a task based on the provided details.
   * @param {Object} req - The request object containing the task details.
   * @param {Object} res - The response object used to send the response.
   */
  async updateTask(req, res) {
    const { id, cur_stat_code, schedule_time, schedule_date, rm_id,fm_id } = req.body;
    console.log("req", req.body);

    try {
      // Step 1: Fetch the current value of `cur_stat_code` for the transaction
      const currentStatus = await this.dbService.getRecordsByFields(
        "dy_transactions",
        "cur_stat_code",
        `id = ${db.escape(id)}`
      );

      const currentStatCode = currentStatus[0]?.cur_stat_code;
      console.log("currentStatCode", currentStatCode);

      // Step 2: If the new `cur_stat_code` is 24, update the `dy_property` table
      if (currentStatCode == 24) {
        const transaction = await this.dbService.getRecordsByFields(
          "dy_transactions",
          "prop_id",
          `id = ${db.escape(id)}`
        );

        const propId = transaction[0]?.prop_id;

        if (propId) {
          // Prepare the request body for updating `dy_property`
          const updatePropertyBody = {
            tbl_name: "dy_property",
            field_values_pairs: { current_status: currentStatCode },
            where_condition: `id = ${db.escape(propId)}`,
          };

          // Use the `updateRecords` method to update `dy_property`
          await this.dbService.updateRecord(
            updatePropertyBody.tbl_name,
            updatePropertyBody.field_values_pairs,
            updatePropertyBody.where_condition
          );
        }
      }

      // Step 3: Prepare dynamic field-value pairs for updating `dy_transactions`
      const fieldValuePairs = {};

      if (cur_stat_code) {
        fieldValuePairs.prev_stat_code = currentStatCode;
        fieldValuePairs.cur_stat_code = cur_stat_code;
      }
      if (schedule_time) {
        fieldValuePairs.schedule_time = schedule_time;
      }
      if (schedule_date) {
        fieldValuePairs.schedule_date = schedule_date;
      }
      if (rm_id) {
        fieldValuePairs.rm_id = rm_id;
      }
      if (fm_id) {
        fieldValuePairs.fm_id = fm_id;
      }

      // Step 4: Prepare the WHERE condition for `dy_transactions`
      const whereCondition = `id = ${db.escape(id)}`;

      // Step 5: Use the `updateRecords` method to update `dy_transactions`
      await this.dbService.updateRecord(
        "dy_transactions",
        fieldValuePairs,
        whereCondition
      );

      // Step 6: Return the success response
      res.status(200).json({
        message: "Task updated successfully.",
      });
    } catch (error) {
      // Log and handle errors
      console.error("Error updating task:", error);
      res.status(500).json({
        message: "Error updating task",
        error: error.message,
      });
    }
  }
}

class addNewRecord extends BaseController {

  /**
   * Adds a new record to the specified table.
   * This method uses a stored procedure to insert a new record into the database.
   * It validates the input and constructs the required parameters for the stored procedure call.
   *
   * @param {Object} req - Express request object containing the request body.
   *        The request body must include `tableName`, `fieldNames`, and `fieldValues`.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: POST /api/addNewRecord
   * // Request body: { "tableName": "dy_rm_fm_com_map", "fieldNames": "community_id, fm_id", "fieldValues": "1, 123" }
   * // Example response: { message: "Record added successfully.", result: { ... } }
   */
  async addNewRecord(req, res) {
    const { tableName, fieldNames, fieldValues } = req.body; // Extract parameters from the request body

    try {
      // Validate required parameters
      if (!tableName || !fieldNames || !fieldValues) {
        return res.status(400).json({
          error:
            "Missing required fields: tableName, fieldNames, or fieldValues.",
        });
      }

      // Call the DatabaseService to execute the stored procedure
      const result = await this.dbService.addNewRecord(
        tableName,
        fieldNames,
        fieldValues
      );

      // Check if the insertion was successful
      if (!result || result.affectedRows === 0) {
        return res.status(500).json({
          error: "Failed to add the new record.",
        });
      }

      // Return the result in a successful response
      res.status(200).json({
        message: "Record added successfully.",
        result: result, // You can return specific fields like insertId or affectedRows
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error adding new record:", error.message);
      res.status(500).json({
        error: "An error occurred while adding the new record.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class getRecords extends BaseController {

  /**
   * Fetches records from the specified table based on given fields and an optional condition.
   * This method uses a stored procedure to retrieve data from the database.
   *
   * @param {Object} req - Express request object containing the query parameters.
   *        The query parameters must include `tableName` and `fieldNames`, and optionally `whereCondition`.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: GET /api/getRecords?tableName=dy_user&fieldNames=id,user_name&whereCondition=role_id=1
   * // Example response: { message: "Records retrieved successfully.", result: [...] }
   */
  async getRecords(req, res) {
    const { tableName, fieldNames, whereCondition } = req.query; // Extract parameters from query string

    try {
      // Validate required parameters
      if (!tableName || !fieldNames) {
        return res.status(400).json({
          error: "Missing required fields: tableName or fieldNames.",
        });
      }

      // Fetch the data using the DatabaseService
      const results = await this.dbService.getRecordsByFields(
        tableName,
        fieldNames,
        whereCondition || "" // Default to an empty string if no condition is provided
      );

      // Check if no records are found
      if (!results || results.length === 0) {
        return res
          .status(404)
          .json({ error: "No records found for the given query." });
      }

      // Return the results in a successful response
      res.status(200).json({
        message: "Records retrieved successfully.",
        result: results, // List of records matching the query
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching records by fields:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching records.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class updateRecord extends BaseController {

  /**
   * Updates a record in the specified table based on given field-value pairs and an optional condition.
   * This method uses a stored procedure to update data in the database.
   *
   * @param {Object} req - Express request object containing the request body.
   *        The request body must include `tableName`, `fieldValuePairs`, and optionally `whereCondition`.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: PUT /api/updateRecord
   * // Request body: { "tableName": "dy_user", "fieldValuePairs": "user_name='John Doe'", "whereCondition": "id=1" }
   * // Example response: { message: "Record updated successfully.", result: { ... } }
   */
  async updateRecord(req, res) {
    const { tableName, fieldValuePairs, whereCondition } = req.body; // Extract parameters from the request body

    try {
      // Validate required parameters
      if (!tableName || !fieldValuePairs) {
        return res.status(400).json({
          error: "Missing required fields: tableName or fieldValuePairs.",
        });
      }

      // Call the DatabaseService to execute the stored procedure
      const result = await this.dbService.updateRecord(
        tableName,
        fieldValuePairs,
        whereCondition || "" // Default to an empty string if no condition is provided
      );

      // Check if the update was successful
      if (!result || result.affectedRows === 0) {
        return res.status(404).json({
          error:
            "No records were updated. Please check the conditions provided.",
        });
      }

      // Return the result in a successful response
      res.status(200).json({
        message: "Record updated successfully.",
        result: result[0], // Result of the update operation
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error updating record:", error.message);
      res.status(500).json({
        error: "An error occurred while updating the record.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class deleteRecord extends BaseController {

  /**
   * Deletes records from the specified table based on an optional condition.
   * This method uses a stored procedure to delete data from the database.
   *
   * @param {Object} req - Express request object containing the request body.
   *        The request body must include `tableName` and optionally `whereCondition`.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: DELETE /api/deleteRecord
   * // Request body: { "tableName": "dy_user", "whereCondition": "id=1" }
   * // Example response: { message: "Record(s) deleted successfully.", result: { ... } }
   */
  async deleteRecord(req, res) {
    const { tableName, whereCondition } = req.body;

    try {
      if (!tableName) {
        return res
          .status(400)
          .json({ error: "Missing required field: tableName." });
      }
      // First, check if the record exists by performing a SELECT query
      const checkRecordExistence = await this.dbService.getRecordsByFields(
        tableName,
        "*",
        whereCondition
      );

      if (!checkRecordExistence || checkRecordExistence.length === 0) {
        // If no records are found, return an error
        return res.status(404).json({
          error: `No records found`,
        });
      }

      const result = await this.dbService.deleteRecord(
        tableName,
        whereCondition || ""
      );

      // Assuming result contains the number of affected rows directly
      if (!result || result.affectedRows == 0) {
        return res.status(404).json({
          error:
            "No records were deleted. Please check the conditions provided.",
          details: { tableName, whereCondition },
        });
      }

      res.status(200).json({
        message: "Record(s) deleted successfully.",
      });
    } catch (error) {
      console.error("Error deleting record(s):", error.message);
      res.status(500).json({
        error: "An error occurred while deleting the record(s).",
        details: error.message,
      });
    }
  }
}

class addRmTask extends BaseController {

  /**
   * Assigns a Relationship Manager (RM) to a transaction.
   * Implements the logic to determine the optimal RM without using a specific stored procedure.
   * @param {Object} req - Express request object containing user_id and property_id in the body.
   * @param {Object} res - Express response object for sending responses.
   */

  async addRmTask(req, res) {
    const { user_id, property_id } = req.body; // Extract user_id and property_id from the request body
    console.log("req", req.body);

    // Validate the input: Ensure both user_id and property_id are provided
    if (!user_id || !property_id) {
      return res.status(400).json({
        error: "user_id and property_id are required.",
      });
    }

    try {
      // Step 1: Fetch the community_id from the dy_property table
      const properties = await this.dbService.getRecordsByFields(
        "dy_property",
        "community_id",
        `id = ${db.escape(property_id)}`
      );
      console.log("2", properties);

      if (!properties || properties.length === 0) {
        return res.status(404).json({ error: "Property not found." });
      }

      const community_id = properties[0].community_id;
      console.log("3", community_id);

      // Step 1.1: Check if a transaction already exists for the given user_id and property_id
      const existingTransaction = await this.dbService.getRecordsByFields(
        "dy_transactions",
        "rm_id",
        `user_id = ${db.escape(user_id)} AND prop_id = ${db.escape(
          property_id
        )}`
      );

      let rm_id;
      let rm_mobile_number = false; // Default to false for mobile number

      if (existingTransaction && existingTransaction.length > 0) {
        // If transaction exists, use the rm_id from the existing transaction
        rm_id = existingTransaction[0].rm_id;
        console.log("Existing RM ID:", rm_id);

        // Fetch the mobile number of the RM from dy_user table
        const rmUser = await this.dbService.getRecordsByFields(
          "dy_user",
          "mobile_no",
          `id = ${db.escape(rm_id)}`
        );

        if (rmUser && rmUser.length > 0) {
          rm_mobile_number = rmUser[0].mobile_no;
        }
      } else {
        // Step 2: If no existing transaction, find the optimal RM (least number of transactions)
        const rmResults = await this.dbService.getGroupedData(
          "dy_transactions",
          "rm_id", // Group by rm_id
          "id", // Aggregate by counting the id field (transactions)
          "COUNT", // Aggregate function (COUNT)
          "" // No WHERE condition
        );

        console.log("4", rmResults);

        // Filter out entries with null rm_id and handle missing transaction_count
        const validRmResults = rmResults.filter(
          (rm) => rm.rm_id !== null && rm.Agg_Res !== null
        );
        console.log("Filtered RM Results:", validRmResults);

        if (!validRmResults || validRmResults.length === 0) {
          return res
            .status(404)
            .json({ error: "No valid Relationship Managers found." });
        }

        // Sort the results by the transaction count (Agg_Res)
        rm_id = validRmResults.sort((a, b) => a.Agg_Res - b.Agg_Res)[0].rm_id;
        console.log("Optimal RM ID:", rm_id);

        // Step 3: Insert the new transaction into dy_transactions
        const insertFields = "user_id, prop_id, rm_id, cur_stat_code";
        const insertValues = `${user_id}, ${property_id}, ${rm_id}, 1`; // Convert array to comma-separated string
        console.log("6", insertFields, insertValues);

        await this.dbService.addNewRecord(
          "dy_transactions",
          insertFields,
          insertValues
        );
      }

      // Respond with success or failure based on the existence of the transaction
      res.status(200).json({
        message:
          existingTransaction && existingTransaction.length > 0
            ? "Transaction already exists."
            : "Transaction assigned successfully.",
        assigned_rm_id: rm_id,
        rm_mobile_number: rm_mobile_number,
      });
    } catch (error) {
      // Log the error and send an error response
      console.error("Error assigning RM to transaction:", error.message);
      res.status(500).json({
        error: "An error occurred while assigning the transaction.",
        details: error.message,
      });
    }
  }
}

class getPropertyAndRequestStats extends BaseController {

  /**
   * Fetches total properties, pending properties, total requests, and total communities.
   *
   * @param {Object} req - Express request object.
   * @param {Object} res - Express response object.
   * @returns {Promise<void>} - The function sends the response with the calculated totals.
   */
  async getPropertyAndRequestStats(req, res) {
    try {
      // Query for total properties (current_status = 3) using getAggregateValue
      const totalProperties = await this.dbService.getAggregateValue(
        "dy_property",
        "current_status",
        "COUNT",
        "current_status = 3"
      );

      // Query for pending properties (current_status = 1)
      const pendingProperties = await this.dbService.getAggregateValue(
        "dy_property",
        "current_status",
        "COUNT",
        "current_status = 1"
      );

      // Query for total requests (count of transactions)
      const totalRequests = await this.dbService.getAggregateValue(
        "dy_transactions",
        "id",
        "COUNT",
        null
      );

      // Query for total communities (count of communities where rstatus = 1)
      const totalCommunities = await this.dbService.getAggregateValue(
        "st_community",
        "rstatus",
        "COUNT",
        "rstatus = 1"
      );

      // Return the results in the response
      res.status(200).json({
        message: "Retrieved successfully.",
        result: {
          total_properties: totalProperties[0].result, // Adjusted to return 'result' from the procedure output
          pending_properties: pendingProperties[0].result, // Adjusted to return 'result' from the procedure output
          total_requests: totalRequests[0].result, // Adjusted to return 'result' from the procedure output
          total_communities: totalCommunities[0].result, // Adjusted to return 'result' from the procedure output
        },
      });
    } catch (error) {
      console.error(
        "Error fetching property and request stats:",
        error.message
      );
      res.status(500).json({
        error: "An error occurred while fetching the stats.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class getTopCommunities extends BaseController {

  /**
   * Fetches the top 4 community names based on transaction count.
   * This method retrieves the top communities by joining the 'dy_transactions', 'dy_property', and 'st_community' tables.
   * It groups by community ID and sorts by transaction count in descending order, limiting the results to 4.
   *
   * @param {Object} req - Express request object (not used in this method but included for consistency).
   * @param {Object} res - Express response object used to send back the response.
   *
   * @returns {Promise<void>} - Sends a JSON response containing the top 4 communities or an error message.
   *
   * @throws {Error} - If any error occurs during the database operation, it will be caught and returned in the response.
   *
   * Example:
   *
   * // Example request: GET /api/getTopCommunities
   * // Example response: { message: "Retrieved successfully.", result: [...] }
   */


  async getTopCommunities(req, res) {
    try {
      console.log("Starting to fetch top communities...");

      // Define the main table and its alias for the query
      const mainTable = "dy_transactions t"; // Main table alias
      console.log("Main table set:", mainTable);
      const associatedProperties = await this.dbService.getJoinedData(
        mainTable,
        `INNER JOIN dy_property p ON t.prop_id = p.id
INNER JOIN st_community ON p.community_id = st_community.id
`,
        `st_community.name AS community_name,st_community.id AS community_id`,
        ""
      );
      console.log("assss", associatedProperties);

      // Group the data by community_name and count the occurrences
      const groupedData = associatedProperties.reduce((acc, curr) => {
        const community = curr.community_name;
        const id = curr.community_id;

        if (!acc[community]) {
          acc[community] = { id, name: community, count: 0 };
        }
        acc[community].count += 1;
        return acc;
      }, {});

      // Convert grouped data to an array
      const groupedArray = Object.values(groupedData);
      console.log("Grouped data:", groupedArray);

      // Sort the grouped data by count in descending order
      const sortedData = groupedArray.sort((a, b) => b.count - a.count);

      // Limit the results to the top 4 communities
      const topCommunities = sortedData.slice(0, 4);
      console.log("Top 4 communities:", topCommunities);

      // Return the results in a successful response
      res.status(200).json({
        message: "Retrieved successfully.",
        result: topCommunities,
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching top communities:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching top communities.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}



class UserProfile extends BaseController {

  /**
   * Fetches user profile information along with user details.
   * This method retrieves data from `dy_user_profile` and joins it with `dy_user` using the `user_id` field.
   *
   * @param {Object} req - Express request object containing the query parameters.
   *        The user_id is extracted from `req.query` to filter the results.
   *
   * @param {Object} res - Express response object used to send back the response.
   *        The results are returned as JSON with either a success message or an error message.
   *
   * @returns {Promise<void>} - The function does not return anything explicitly but sends a response to the client.
   *
   * Example:
   *
   * // Example request: GET /api/getUserProfile?user_id=123
   * // Example response: { message: "Retrieved successfully.", result: [...] }
   */
  async getUserProfile(req, res) {
    const { user_id } = req.query; // Extract user_id from query parameters

    try {
      // Define the main table and its alias for the query
      const tableName = `dy_user_profile p`; // Main table alias

      // Define the JOIN clauses to link the main table with dy_user
      const joinClauses = `LEFT JOIN dy_user u ON p.user_id = u.id
          LEFT JOIN st_conv_mode cm ON p.conv_mode_id = cm.id
      LEFT JOIN st_gender g ON u.gender_id = g.id
      LEFT JOIN st_billing_plan bp ON u.bill_plan = bp.id
      LEFT JOIN st_role r ON u.role_id = r.id
`; // Join clause for fetching user data

      // Define the fields to select from both tables
      const fieldNames = `
      p.user_id, p.current_city, p.alt_email_id, p.alt_mobile_no, 
       p.Interests, p.last_updated,
      u.auth0id, u.user_name, u.email_id, u.mobile_no, u.role_id, 
      u.ref_code, u.mobile_verified, u.email_verified,
      u.signuptime, g.gender_type AS gender, bp.billing_plan AS bill_plan, 
      bp.billing_amount, bp.billing_duration, cm.conv_mode AS conversation_mode, r.role AS user_role,
      u.last_updated AS user_last_updated
    `;

      // If user_id is provided, escape it to prevent SQL injection
      const whereCondition = user_id
        ? `p.user_id = ${db.escape(user_id)}` // Escape user_id to avoid SQL injection
        : "";

      // Fetch the data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      // Check if no records are found
      if (!results || results.length === 0) {
        return res
          .status(404)
          .json({ error: "No records found for the provided user_id." });
      }
      const conv_mode = await this.dbService.getRecordsByFields(
        "st_conv_mode",
        "id, conv_mode"
      );
      const gender = await this.dbService.getRecordsByFields(
        "st_gender",
        "id, gender_type"
      );

      // Return the results in a successful response
      res.status(200).json({
        message: "Retrieved successfully.",
        result: results, // User profile information along with user details
        //result: mappedResults, // User profile information along with user details
        conv_mode: conv_mode,
        gender: gender,
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching user profile data:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching user profile data.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class UserController extends BaseController {

  /**
   * Fetches all RMs (Role ID = 3) and FMs (Role ID = 4) from the dy_user table.
   * RMs are listed first, followed by FMs.
   *
   * @param {Object} req - Express request object (no query parameters needed).
   * @param {Object} res - Express response object used to send the response.
   *
   * @returns {Promise<void>} - Sends a response with the grouped list of RMs and FMs.
   *
   * Example:
   *
   * // Example request: GET /api/getUsersByRoleGrouped
   * // Example response:
   * // {
   * //   "message": "Users retrieved successfully.",
   * //   "result": {
   * //     "RMs": [
   * //       { "user_name": "John Doe", "role_id": 3 },
   * //       { "user_name": "Alice", "role_id": 3 }
   * //     ],
   * //     "FMs": [
   * //       { "user_name": "Jane Smith", "role_id": 4 },
   * //       { "user_name": "Bob", "role_id": 4 }
   * //     ]
   * //   }
   * // }
   */
  async getUsersByRole(req, res) {
    try {
      // Define the table and fields to fetch
      const tableName = "dy_user"; // Main table
      const fieldNames = "user_name, role_id"; // Fields to select

      // Fetch RMs (Role ID = 3)
      const rmCondition = `role_id = 3`; // Condition for RMs
      const rmResults = await this.dbService.getRecordsByFields(
        tableName,
        fieldNames,
        rmCondition
      );

      // Fetch FMs (Role ID = 4)
      const fmCondition = `role_id = 4`; // Condition for FMs
      const fmResults = await this.dbService.getRecordsByFields(
        tableName,
        fieldNames,
        fmCondition
      );

      // Check if no records are found
      if (
        (!rmResults || rmResults.length === 0) &&
        (!fmResults || fmResults.length === 0)
      ) {
        return res
          .status(404)
          .json({ error: "No RMs or FMs found in the database." });
      }

      // Return the results in a grouped response
      res.status(200).json({
        message: "Users retrieved successfully.",
        result: {
          RMs: rmResults || [], // List of RMs
          FMs: fmResults || [], // List of FMs
        },
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching users by role:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching users by role.",
        details: error.message, // Provide error details for debugging
      });
    }
  }
}



module.exports = {
  UserActionsController,
  PropertyController,
  FMController,
  TaskController,
  addNewRecord,
  getRecords,
  updateRecord,
  deleteRecord,
  addRmTask,
  updateTask,
  getPropertyAndRequestStats,
  getTopCommunities,
  UserProfile,
  UserController,
};
