const DatabaseService = require("../utils/service"); // Correct import path
const db = require("../config/db"); // Database connection object
const { propertyFields, fieldNames1 } = require("../utils/joins");
require("dotenv").config();
const BaseController = require("../utils/baseClass"); // Adjust the path as needed

class FMController extends BaseController {


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
        whereClauses.push(`scity.id IN (${escapedCities})`);
      }
      if (builders) {
        const buildersArray = builders.split(",").map((b) => b.trim());
        const escapedBuilders = buildersArray
          .map((b) => db.escape(b))
          .join(", ");
        whereClauses.push(`sb.id IN (${escapedBuilders})`);
      }
      if (community) {
        const communityArray = community.split(",").map((c) => c.trim());
        const escapedCommunities = communityArray
          .map((c) => db.escape(c))
          .join(", ");
        whereClauses.push(`sc.id IN (${escapedCommunities})`);
      }
      if (hometype) {
        const hometypeArray = hometype.split(",").map((h) => h.trim());
        const escapedHometypes = hometypeArray
          .map((h) => db.escape(h))
          .join(", ");
        whereClauses.push(`dy.home_type_id IN (${escapedHometypes})`);
      }
      if (propertydescription) {
        const propertyDescArray = propertydescription
          .split(",")
          .map((d) => d.trim());
        const escapedDescs = propertyDescArray
          .map((d) => db.escape(d))
          .join(", ");
        whereClauses.push(`dy.prop_desc_id IN (${escapedDescs})`);
      }

      const whereCondition =
        whereClauses.length > 0 ? whereClauses.join(" AND ") : "1";

      // Fetch data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      const paginatedResults = results.slice(offset, offset + sanitizedLimit);
      const totalRecords = results.length;
      const totalPages = Math.ceil(totalRecords / sanitizedLimit);

      // Enhance results with pincode information
      const enhancedResults = await Promise.all(
        paginatedResults.map(async (property) => {
          const address = property.address || "";
          const pincodeMatch = address.match(/\b\d{6}\b/);
          const pincode = pincodeMatch ? pincodeMatch[0] : null;
          const pincodeUrl = pincode
            ? `https://api.postalpincode.in/pincode/${pincode}`
            : null;

          // Fetch amenities for each property
          const amenities = await this.getAmenities({ community_id: property.community_id });


          const landmarks = await this.landMarks({ community_id: property.community_id });


          return {
            ...property,
            pincode,
            pincode_url: pincodeUrl,
            amenities,
            landmarks
          };
        })
      );

      res.status(200).json({
        message: property_id
          ? `Details for property ID: ${property_id}`
          : `All property details`,
        pagination: {
          currentPage: sanitizedPage,
          totalPages,
          totalRecords,
          limit: sanitizedLimit,
        },
        results: enhancedResults,
      });
    } catch (error) {
      console.error("Error fetching property details:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching property details.",
        details: error.message,
      });
    }
  }

  async getAmenities({ community_id }) {
    try {
      const tableName = `st_amenity_category ac`;
  
      const joinClauses = `
        LEFT JOIN rufrent.st_amenities sa ON ac.id = sa.amenity_category_id AND sa.rstatus = 1
        LEFT JOIN rufrent.dy_amenities ma ON ma.amenity = sa.id
        LEFT JOIN rufrent.st_community ka ON ka.id = ma.community AND ka.rstatus = 1
      `;
  
      const fieldNames = `
        ka.name AS community_name,
        GROUP_CONCAT(DISTINCT sa.amenity_name) AS amenities,
        ac.amenity_category AS category
      `;
  
      const whereCondition = `
        ka.id = ${db.escape(community_id)} AND ka.name IS NOT NULL
      `;
  
      const groupByClause = `
        GROUP BY ka.name, ac.amenity_category
      `;
  
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        `${whereCondition} ${groupByClause}`
      );
  
      // Transform amenities from comma-separated string to an array
      return results.map(row => ({
        ...row,
        amenities: row.amenities ? row.amenities.split(',') : []
      }));
    } catch (error) {
      console.error("Error fetching amenities:", error.message);
      throw new Error("Failed to fetch amenities.");
    }
  }
  

  async landMarks({ community_id }) {
    try {
      const tableName = `dy_landmarks dl`;
  
      const joinClauses = `
        LEFT JOIN st_landmarks_category slc ON dl.landmark_category_id = slc.id
      `;
  
      const fieldNames = `
        dl.community_id AS community_id,
        GROUP_CONCAT(DISTINCT dl.landmark_name) AS landmarks,
        slc.landmark_category AS category
      `;
  
      const whereCondition = `
        dl.community_id = ${db.escape(community_id)}
      `;
  
      const groupByClause = `
        GROUP BY dl.community_id, slc.landmark_category
      `;
  
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        `${whereCondition} ${groupByClause}`
      );
  
      // Transform landmarks from comma-separated string to an array
      return results.map(row => ({
        ...row,
        landmarks: row.landmarks ? row.landmarks.split(',') : []
      }));
    } catch (error) {
      console.error("Error fetching landmarks:", error.message);
      throw new Error("Failed to fetch landmarks.");
    }
  }
  
  
}

class UserActionsController extends BaseController {


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

      // Fetch matching properties for the given user_id
let userProperties = [];
if (user_id) {
  const mainTable = "dy_transactions dt";
  const joinClauses = `
  LEFT JOIN dy_user u ON dt.rm_id = u.id
  LEFT JOIN dy_property dy ON dt.prop_id = dy.id
  LEFT JOIN st_current_status sct ON dt.cur_stat_code = sct.id

  ${propertyFields}
`;

  const fields = `dt.prop_id,sct.status_code,dt.tr_st_time,u.user_name,u.mobile_no,${fieldNames1}`;
  const whereClause = `dt.user_id = ${db.escape(user_id)}`;

  // Fetch data using getJoinedData
  userProperties = await this.dbService.getJoinedData(
    mainTable,
    joinClauses,
    fields,
    whereClause
  );

  const uniqueProperties = [];
  const seenProps = new Set();

  userProperties.forEach((item) => {
    if (!seenProps.has(item.prop_id)) {
      seenProps.add(item.prop_id);
      uniqueProperties.push({
        prop_id: item.prop_id,
        property_added_at: item.tr_st_time,
        user_name: item.user_name,
        RM_mobile_no: item.mobile_no,
        current_status:item.status_code,
        id: item.id,
        propert_current_status: item.current_status,
        prop_type: item.prop_type,
        home_type: item.home_type,
        prop_desc: item.prop_desc,
        community_name: item.community_name,
        map_url: item.map_url,
        total_area: item.total_area,
        open_area: item.open_area,
        nblocks: item.nblocks,
        nfloors_per_block: item.nfloors_per_block,
        nhouses_per_floor: item.nhouses_per_floor,
        address: item.address,
        totflats: item.totflats,
        default_images: item.default_images,
        nbeds: item.nbeds,
        nbaths: item.nbaths,
        nbalcony: item.nbalcony,
        eat_pref: item.eat_pref,
        parking_count: item.parking_count,
        deposit: item.deposit,
        maintenance_type: item.maintenance_type,
        rental_low: item.rental_low,
        rental_high: item.rental_high,
        tower_no: item.tower_no,
        floor_no: item.floor_no,
        flat_no: item.flat_no,
        images_location: item.images_location,
        builder_name: item.builder_name,
        city_name: item.city_name,
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
       u2.email_id AS owner_email,
        u1.user_name AS tenant_name,
        u1.mobile_no AS tenant_mobile,
        u1.email_id As tenant_email,
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


  async updateTask(req, res) {
    const { id, cur_stat_code, schedule_time, schedule_date, rm_id,fm_id } = req.body;
    console.log("req", req.body);

    try {
      const currentStatus = await this.dbService.getRecordsByFields(
        "dy_transactions",
        "cur_stat_code",
        `id = ${db.escape(id)}`
      );

      const currentStatCode = currentStatus[0]?.cur_stat_code;

      // Step 2: If the new `cur_stat_code` is 24, update the `dy_property` table
      if (currentStatCode == 20) {
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
            field_values_pairs: { current_status: 24 },
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


  async addRmTask(req, res) {
    const { user_id, property_id,cur_stat_code } = req.body; // Extract user_id and property_id from the request body
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


        // Sort the results by the transaction count (Agg_Res)
        rm_id = validRmResults.sort((a, b) => a.Agg_Res - b.Agg_Res)[0].rm_id;
        console.log("Optimal RM ID:", rm_id);

        // Step 3: Insert the new transaction into dy_transactions
        const insertFields = "user_id, prop_id, rm_id, cur_stat_code";
        const insertValues = `${user_id}, ${property_id}, ${rm_id}, ${cur_stat_code}`; // Convert array to comma-separated string
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
      u.uid, u.user_name, u.email_id, u.mobile_no, u.role_id, 
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

class LandMarksController extends BaseController {

  async addLandmarks(req, res) {
    const { community_id, landmarks } = req.body;

    if (!community_id || !Array.isArray(landmarks) || landmarks.length === 0) {
      return res.status(400).json({
        error:
          "Invalid input. Please provide a community_id and a list of landmarks.",
      });
    }

    try {
      const tableName = "dy_landmarks"; // Target table
      const fieldNames =
        "landmark_name, `distance`, landmark_category_id, community_id"; // Fields to insert

      const errors = []; // Store any errors during insertion

      for (const landmark of landmarks) {
        const { landmark_name, distance, landmark_category_id } = landmark;

        // Validate landmark fields
        if (!landmark_name || distance == null || !landmark_category_id) {
          errors.push({
            landmark_name,
            distance,
            landmark_category_id,
            error:
              "Invalid landmark data. Ensure all required fields are provided.",
          });
          continue;
        }

        try {
          // Format the fieldValues as a comma-separated string
          const fieldValues = `'${landmark_name}', ${distance}, ${landmark_category_id}, ${community_id}`;

          // Call the addNewRecord method
          await this.dbService.addNewRecord(tableName, fieldNames, fieldValues);
        } catch (error) {
          console.error(
            `Failed to add landmark "${landmark_name}" for community_id ${community_id}:`,
            error.message
          );
          errors.push({
            landmark_name,
            distance,
            landmark_category_id,
            error: error.message,
          });
        }
      }

      // Check for errors and send an appropriate response
      if (errors.length > 0) {
        return res.status(207).json({
          message: "Some landmarks were not added successfully.",
          errors,
        });
      }

      // If all landmarks are added successfully, send a success response
      res.status(200).json({
        message: "All landmarks added successfully to the community.",
      });
    } catch (error) {
      console.error("Error adding landmarks:", error.message);
      res.status(500).json({
        error: "An unexpected error occurred while adding landmarks.",
        details: error.message,
      });
    }
  }

  async landMarks(req, res) {
    const { community_id } = req.query; // Extract community_id from query parameters

    try {
      // Define the main table and its alias for the query
      const tableName = `dy_landmarks dl`; // Main table alias

      // Define the JOIN clauses to link the main table with other tables
      const joinClauses = `      LEFT JOIN st_landmarks_category slc ON dl.landmark_category_id = slc.id
`;
      // Define the fields to select from the database
      const fieldNames = `   dl.landmark_name AS landmark_name,
        dl.distance AS distance,
        dl.landmark_category_id AS landmark_category_id,
        slc.landmark_category AS landmark_category

`; // Fields to select

      // If community_id is provided, escape it to prevent SQL injection
      const whereCondition = community_id
        ? `dl.community_id = ${db.escape(community_id)}` // Escape community_id to avoid SQL injection
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

  async importLandmarks(req, res) {
    const { source_community_id, target_community_id } = req.query;
  
    try {
      // Validate the required parameters
      if (!source_community_id || !target_community_id) {
        return res.status(400).json({
          error: "Both source_community_id and target_community_id are required.",
        });
      }
  
      // Fetch all landmarks associated with the source community ID
      const whereCondition = `community_id = ${db.escape(source_community_id)}`;
      const landmarks = await this.dbService.getRecordsByFields(
        "dy_landmarks",
        "landmark_name, distance, landmark_category_id",
        whereCondition
      );
  
      if (landmarks.length === 0) {
        return res.status(404).json({
          message: "No landmarks found for the provided source_community_id.",
        });
      }
  
      // Track which landmarks were added and which were already present
      const addedLandmarks = [];
      const existingLandmarks = [];
  
      // Insert each landmark into the dy_landmarks table for the target community ID
      const insertPromises = landmarks.map(async (landmark) => {
        // Check if the landmark already exists for the target community
        const whereCondition = `landmark_name = ${db.escape(
          landmark.landmark_name
        )} AND community_id = ${db.escape(target_community_id)}`;
        const existingLandmark = await this.dbService.getRecordsByFields(
          "dy_landmarks",
          "id",
          whereCondition
        );
  
        if (existingLandmark.length === 0) {
          // If it doesn't exist, insert the landmark
          const insertData = {
            landmark_name: landmark.landmark_name,
            distance: landmark.distance,
            landmark_category_id: landmark.landmark_category_id,
            community_id: target_community_id,
          };
  
          await this.dbService.addNewRecord(
            "dy_landmarks",
            Object.keys(insertData).join(", "),
            Object.values(insertData)
              .map((value) => db.escape(value))
              .join(", ")
          );
          addedLandmarks.push(landmark.landmark_name); // Track added landmark
        } else {
          existingLandmarks.push(landmark.landmark_name); // Track existing landmark
        }
      });
  
      // Wait for all insert operations to complete
      await Promise.all(insertPromises);
  
      // Return a detailed success response
      let message = "Landmarks import process completed.";
      if (addedLandmarks.length > 0) {
        message += ` Added: ${addedLandmarks.join(", ")}.`;
      }
      if (existingLandmarks.length > 0) {
        message += ` Already present: ${existingLandmarks.join(", ")}.`;
      }
  
      res.status(200).json({
        message,
        added_landmarks: addedLandmarks.length,
        existing_landmarks: existingLandmarks.length,
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error cloning landmarks:", error.message);
      res.status(500).json({
        error: "An error occurred while cloning landmarks.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
  
}


class CityBasedCommunitiesController extends BaseController {


  async CityBasedCommunities(req, res) {
    const { city_id} = req.query; // Extract city_id from query parameters

    try {
      if (!city_id) {
        return res.status(400).json({
          error: "city_id is required to fetch communities.",
        });
      }

      // Define the main table and its alias for the query
      const tableName = `st_community sc`; // Main table alias

      // Define the JOIN clauses to link the main table with the builder table
      const joinClauses = `LEFT JOIN st_builder sb ON sc.builder_id = sb.id`;

      // Define the fields to select from the database
      const fieldNames = `
        sc.id AS community_id,
        sc.name AS community_name
      `;

      // Define the WHERE condition to filter by city_id
      const whereCondition = `sb.city_id = ${db.escape(city_id)} AND sc.rstatus = 1 AND sb.rstatus = 1`;

      // Fetch the data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      // Return the results in a successful response
      res.status(200).json({
        message: "Retrieved successfully.",
        result: results, // List of communities for the given city_id
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching communities data:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching communities data.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }
}

class AmenitiesController extends BaseController {
  
  
  async addAmenities(req, res) {
    const { community_id, amenity_ids } = req.body; // Extract community_id and amenity_ids from request body

    try {
      // Validate the input
      if (!community_id || !Array.isArray(amenity_ids) || amenity_ids.length === 0) {
        return res.status(400).json({
          error: "Invalid input. Provide a valid community ID and an array of amenity IDs.",
        });
      }

      // Define the table name
      const tableName = "dy_amenities";

      // Loop through each amenity ID and insert it into the database
      for (const amenityId of amenity_ids) {
        const fieldNames = `amenity, community`; // Fields to insert
        const fieldValues = `${db.escape(amenityId)}, ${db.escape(community_id)}`; // Escaped values

        // Use the DatabaseService to insert each record
        await this.dbService.addNewRecord(tableName, fieldNames, fieldValues);
      }

      // Return a success response
      res.status(200).json({
        message: "Amenities added successfully.",
      });
    } catch (error) {
      // Handle and log any errors
      console.error("Error adding amenities:", error.message);
      res.status(500).json({
        error: "An error occurred while adding amenities.",
        details: error.message,
      });
    }
  }

  async getAmenities(req, res) {
    const { community_id } = req.query; // Extract community_id from query parameters

    try {
      if (!community_id) {
        return res.status(400).json({
          error: "community_id is required to fetch amenities.",
        });
      }

      // Define the main table and its alias for the query
      const tableName = `dy_amenities a`; // Main table alias

      // Define the JOIN clauses to link the main table with other tables
      const joinClauses = `
        LEFT JOIN st_amenities sa ON a.amenity = sa.id
        LEFT JOIN st_amenity_category sac ON sa.amenity_category_id = sac.id
      `;

      // Define the fields to select from the database
      const fieldNames = `
        a.id AS amenity_mapping_id,
        a.community AS community_id,
        sa.id AS amenity_id,
        sa.amenity_name,
        sac.id AS amenity_category_id,
        sac.amenity_category
      `;

      // Create a condition to filter by the given community_id
      const whereCondition = `a.community = ${db.escape(community_id)}`;

      // Fetch the data using the DatabaseService
      const results = await this.dbService.getJoinedData(
        tableName,
        joinClauses,
        fieldNames,
        whereCondition
      );

      // Return the results in a successful response
      res.status(200).json({
        message: "Amenities retrieved successfully.",
        result: results, // List of amenities for the given community_id
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error fetching amenities:", error.message);
      res.status(500).json({
        error: "An error occurred while fetching amenities.",
        details: error.message, // Provide the error details for debugging
      });
    }
  }




  async importAmenities(req, res) {
    const { source_community_id, target_community_id } = req.query;
  
    try {
      // Validate the required parameters
      if (!source_community_id || !target_community_id) {
        return res.status(400).json({
          error: "Both source_community_id and target_community_id are required.",
        });
      }
  
      // Fetch all amenities associated with the source community ID
      const whereCondition = `community = ${db.escape(source_community_id)}`;
      const amenities = await this.dbService.getRecordsByFields(
        "dy_amenities",
        "amenity",
        whereCondition
      );
  
      if (amenities.length === 0) {
        return res.status(404).json({
          message: "No amenities found for the provided source_community_id.",
        });
      }
  
      // Track which amenities were added and which were already present
      const addedAmenities = [];
      const existingAmenities = [];
  
      // Insert each amenity into the dy_amenities table for the target community ID
      const insertPromises = amenities.map(async (amenity) => {
        // Check if the amenity already exists for the target community
        const whereCondition = `amenity = ${db.escape(
          amenity.amenity
        )} AND community = ${db.escape(target_community_id)}`;
        const existingAmenity = await this.dbService.getRecordsByFields(
          "dy_amenities",
          "id",
          whereCondition
        );
  
        if (existingAmenity.length === 0) {
          // If it doesn't exist, insert the amenity
          const insertData = {
            amenity: amenity.amenity,
            community: target_community_id,
          };
  
          await this.dbService.addNewRecord(
            "dy_amenities",
            Object.keys(insertData).join(", "),
            Object.values(insertData)
              .map((value) => db.escape(value))
              .join(", ")
          );
          addedAmenities.push(amenity.amenity); // Track added amenity
        } else {
          existingAmenities.push(amenity.amenity); // Track existing amenity
        }
      });
  
      // Wait for all insert operations to complete
      await Promise.all(insertPromises);
  
      // Return a detailed success response
      let message = "Amenities import process completed.";
      if (addedAmenities.length > 0) {
        message += ` Added: ${addedAmenities.join(", ")}.`;
      }
      if (existingAmenities.length > 0) {
        message += ` Already present: ${existingAmenities.join(", ")}.`;
      }
  
      res.status(200).json({
        message,
        added_amenities: addedAmenities.length,
        existing_amenities: existingAmenities.length,
      });
    } catch (error) {
      // Log and return any errors that occur during the process
      console.error("Error cloning amenities:", error.message);
      res.status(500).json({
        error: "An error occurred while cloning amenities.",
        details: error.message, // Provide the error details for debugging
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
  LandMarksController,
  CityBasedCommunitiesController,
  AmenitiesController


};
