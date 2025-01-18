const db = require("../config/db"); // Database db
require('dotenv').config();


class DatabaseService {

  // async addNewRecord(tableName, fieldNames, fieldValues) {
  //   try {
  //     // Convert fieldValues to an array if it's a string
  //     const valuesArray = Array.isArray(fieldValues)
  //       ? fieldValues
  //       : fieldValues.split(',').map((value) => value.trim());
  
  //     // Ensure the number of fields matches the number of values
  //     const fieldsArray = fieldNames.split(',').map((field) => field.trim());
  //     if (fieldsArray.length !== valuesArray.length) {
  //       throw new Error(
  //         `Column count (${fieldsArray.length}) doesn't match value count (${valuesArray.length}).`
  //       );
  //     }
  
  //     // Join values into a single comma-separated string (no parentheses)
  //     const formattedValues = valuesArray
  //       .map((value) => (value === null ? 'NULL' : `${db.escape(value)}`))
  //       .join(', ');
  
  //     const procedureCall = `CALL addNewRecord(?, ?, ?);`;
  
  //     // Log the query for debugging
  //     console.log('Executing Procedure:', procedureCall, tableName, fieldNames, formattedValues);
  
  //     // Pass raw values (no parentheses) to the stored procedure
  //     const [rows] = await db.execute(procedureCall, [
  //       tableName,
  //       fieldNames,
  //       formattedValues,
  //     ]);
  
  //     return rows[0]; // Return the result
  //   } catch (error) {
  //     console.error('Error executing addNewRecord:', error.message);
  //     throw error;
  //   }
  // } 


  async addNewRecord(tableName, fieldNames, fieldValues) {
    try {
    
      
  
      // Log the query for debugging
      //console.log('Executing Procedure:', CALL addNewRecord(?, ?, ?), tableName, fieldNames, fieldValues);
  
      // Pass raw values (no parentheses) to the stored procedure
      const [rows] = await db.execute(`CALL addNewRecord(?, ?, ?)`, [
        tableName,
        fieldNames,
        fieldValues,
      ]);
  
      return rows[0]; // Return the result
    } catch (error) {
      console.error('Error executing addNewRecord:', error.message);
      throw error;
    }
  }
  
  
  

  async getRecordsByFields(tableName, fieldNames, whereCondition = '') {
    try {
      const procedureCall = `CALL getRecordsByFields(?, ?, ?);`;
      const [rows] = await db.execute(procedureCall, [
        tableName,
        fieldNames,
        whereCondition,
      ]);
      return rows[0]; // Return the result set
    } catch (error) {
      console.error('Error executing getRecordsByFields:', error.message);
      throw error;
    }
  }

  async updateRecord(tableName, fieldValuePairs, whereCondition = '') {
    try {
      // Construct the SET clause dynamically from fieldValuePairs
      let setClause = '';
      for (const [key, value] of Object.entries(fieldValuePairs)) {
        if (setClause !== '') {
          setClause += ', ';
        }
        setClause += `${key} = ?`;
      }
  
      // Prepare the full SQL query
      const procedureCall = `UPDATE ${tableName} SET ${setClause} WHERE ${whereCondition};`;
  
      // Prepare the values for the placeholders in the query
      const values = Object.values(fieldValuePairs);
  
      // Execute the query
      const [rows] = await db.execute(procedureCall, values);
  
      return rows; // Return the result
    } catch (error) {
      console.error('Error executing updateRecord:', error.message);
      throw error;
    }
  }
  

  async deleteRecord(tableName, whereCondition = '') {
    try {
      const procedureCall = `CALL deleteRecord(?, ?);`;
      console.log(`Executing SQL: ${procedureCall} with params: ${tableName}, ${whereCondition}`);

      const [rows] = await db.execute(procedureCall, [
        tableName,
        whereCondition,
      ]);
      return rows[0]; // Return the result
    } catch (error) {
      console.error('Error executing deleteRecord:', error.message);
      throw error;
    }
  }


    
  /**
   * Executes the stored procedure `getJoinedData` to fetch joined data from the database.
   * This method calls a stored procedure in the MySQL database to join multiple tables and retrieve the specified fields.
   * 
   * @param {string} mainTable - Name of the main table in the database (e.g., 'dy_rm_fm_com_map r').
   *        This is the primary table used in the join operation.
   * 
   * @param {string} joinClauses - SQL JOIN clauses as text. 
   *        This defines how the main table should be joined with other tables (e.g., 'LEFT JOIN dy_user u ON r.fm_id = u.id').
   * 
   * @param {string} fields - Fields to select in the query. 
   *        This specifies which columns to retrieve from the database (e.g., 'r.fm_id, u.user_name AS fm_name').
   * 
   * @param {string} [whereClause=''] - Optional WHERE condition for filtering the results.
   *        This condition is applied to restrict the query to certain records (e.g., 'r.community_id = 1').
   *        If not provided, defaults to an empty string, meaning no filtering is applied.
   * 
   * @returns {Promise<Array>} - A promise that resolves to an array containing the result set.
   *        The result is usually returned in the first index of the rows array.
   * 
   * @throws {Error} - If an error occurs while executing the stored procedure, it is thrown and logged.
   * 
   * Example:
   * 
   * const tableName = 'dy_rm_fm_com_map r';
   * const joinClauses = 'LEFT JOIN dy_user u ON r.fm_id = u.id';
   * const fields = 'r.fm_id, u.user_name AS fm_name';
   * const whereClause = 'r.community_id = 1';
   * 
   * try {
   *   const results = await dbService.getJoinedData(tableName, joinClauses, fields, whereClause);
   *   console.log(results);
   * } catch (error) {
   *   console.error('Error fetching data:', error);
   * }
   */
  async getJoinedData(mainTable, joinClauses, fields, whereClause = '') {
    
    try {

      // Call the stored procedure `getJoinedData` with the provided parameters.
      const procedureCall = `CALL getJoinedData(?, ?, ?, ?);`;
          // Log the procedure call before executing

      
      // Execute the stored procedure using db.execute with the parameters passed to the method.
      const [rows] = await db.execute(procedureCall, [
        mainTable,
        joinClauses,
        fields,
        whereClause,
      ]);
      
      // Return the result set, typically in the first index of the rows array.
      return rows[0]; // The result set is usually in the first index.
    } catch (error) {
      // Log and throw any errors that occur during the query execution.
      console.error('Error executing getJoinedData:', error.message);
      throw error;
    }
  }




   /**
   * Executes the stored procedure `getGroupedData` to fetch grouped data from the database.
   * @param {string} tableName - Name of the table.
   * @param {string} groupField - Field to group by.
   * @param {string} aggregateField - Field to apply the aggregate function on.
   * @param {string} aggregateFunction - Aggregate function (e.g., SUM, AVG, MAX, MIN, COUNT).
   * @returns {Promise<Array>} - The grouped data result set.
   */
   async getGroupedData(tableName, groupField, aggregateField, aggregateFunction, whereCondition = '') {
    try {

          // Log the parameters to debug the query

        // Check if whereCondition is provided
        const procedureCall = `CALL getGroupedData(?, ?, ?, ?, ?);`;

        // Pass the parameters, including the whereCondition (default to an empty string if not provided)
        const [rows] = await db.execute(procedureCall, [
            tableName,
            groupField,
            aggregateField,
            aggregateFunction,
            whereCondition,  // This is the new parameter
        ]);

        // Return the first row of the result
        return rows[0];
    } catch (error) {
        console.error('Error executing getGroupedData:', error.message);
        throw error;
    }
}

  

  /**
   * Executes the stored procedure `getAggregateValue` to fetch an aggregate value from the database.
   * @param {string} tableName - Name of the table.
   * @param {string} fieldName - Field to apply the aggregate function on.
   * @param {string} aggregateFunction - Aggregate function (e.g., SUM, AVG, MAX, MIN, COUNT).
   * @returns {Promise<Object>} - The result containing the aggregate value.
   */
  async getAggregateValue(tableName, fieldName, aggregateFunction, whereCondition = '') {
    try {
      const procedureCall = `CALL getAggregateValue(?, ?, ?, ?);`;
      const [rows] = await db.execute(procedureCall, [
        tableName,
        fieldName,
        aggregateFunction,
        whereCondition // Pass the whereCondition to the stored procedure
      ]);
      return rows[0]; // Return the result
    } catch (error) {
      console.error('Error executing getAggregateValue:', error.message);
      throw error;
    }
}


  /**
   * Executes the stored procedure `getSortedData` to fetch sorted data from the specified table.
   * @param {string} Tbl_Name - The name of the table to query.
   * @param {string} Order_Field_Name - The field to order the results by.
   * @param {string} Sort_Type - The sorting order (either 'ASC' or 'DESC').
   * @returns {Promise<Array>} - A promise that resolves to the result set.
   * @throws {Error} - If an error occurs during the database operation.
   */
  async getSortedData(Tbl_Name, Order_Field_Name, Sort_Type) {
    try {
      // Validate the sort direction
      if (!['ASC', 'DESC'].includes(Sort_Type)) {
        throw new Error('Invalid sort direction. Use ASC or DESC.');
      }

      // Call the stored procedure `getSortedData` with the provided parameters
      const procedureCall = `CALL getSortedData(?, ?, ?);`;
      const [rows] = await db.execute(procedureCall, [
        Tbl_Name,
        Order_Field_Name,
        Sort_Type
      ]);
      
      // Return the result set (usually the first index contains the data)
      return rows[0];
    } catch (error) {
      // Log and throw any errors that occur during the query execution
      console.error('Error executing getSortedData:', error.message);
      throw error;
    }
  }


  async executeRawQuery(query) {
    try {
      // Execute the raw SQL query
      const [rows] = await db.execute(query);
      return rows;
    } catch (error) {
      console.error('Error executing raw query:', error.message);
      throw error;
    }
  }


}




module.exports = DatabaseService;
