const db = require("../config/db");
const dotenv = require("dotenv");
const DatabaseService = require("../utils/service");
const BaseController = require("../utils/baseClass");


dotenv.config();

class AuthController extends BaseController {

  async fetchRoleName(roleId) {
    const roleResults = await this.dbService.getRecordsByFields(
      "st_role",
      "role",
      `id = ${db.escape(roleId)}`
    );
    return roleResults.length > 0 ? roleResults[0].role : null;
  }

  validateFields(fields, requiredFields) {
    const missingFields = requiredFields.filter((field) => !fields[field]);
    return missingFields.length > 0
      ? `Missing required fields: ${missingFields.join(", ")}`
      : null;
  }

  async signup(req, res) {
    const { uid, email, displayName, mobile_no, role_id, token } = req.body;
    const validationError = this.validateFields(req.body, [
      "uid",
      "email",
      "role_id",
      "token",
    ]);
    if (validationError) {
      return res.status(400).json({ message: validationError });
    }

    try {
      const existingUser = await this.dbService.getRecordsByFields(
        "dy_user",
        "*",
        `uid = ${db.escape(uid)}`
      );
      if (existingUser.length > 0) {
        return res.status(409).json({ message: "User already exists. Please login." });
      }

      const roleName = await this.fetchRoleName(role_id);
      if (!roleName) {
        return res.status(400).json({ message: "Invalid role_id. Role not found." });
      }
                      // Generate a unique referral code
    const generateReferralCode = () => {
      return Math.random().toString(36).substring(2, 10);
    };
    let referralCode;
    let isUnique = false;

    while (!isUnique) {
      referralCode = generateReferralCode();
      const existingCode = await this.dbService.getRecordsByFields(
        "dy_user",
        "ref_code",
        `ref_code = ${db.escape(referralCode)}`
      );
      isUnique = existingCode.length === 0; // Check if no records match the generated referral code
    }


      const fieldNames = "uid, user_name, email_id, mobile_no, role_id,ref_code";
      const fieldValues = `${db.escape(uid)}, ${db.escape(displayName || null)}, ${db.escape(email)}, ${db.escape(mobile_no || null)}, ${db.escape(role_id)},${db.escape(referralCode)}`;
      const ress=await this.dbService.addNewRecord("dy_user", fieldNames, fieldValues);
      console.log("response", ress);
      res.status(201).json({
        message: "User registered successfully.",
        token,
        uid,
        role: roleName,
        email,
        username:displayName||null,
      });
    } catch (err) {
      console.error("Error during signup:", err.message);
      res.status(500).json({ message: "Internal server error." });
    }
  }


  async g_login(req, res) {
    const { uid, email, displayName, mobile_no, token, role_id } = req.body;
  
    // Check if required fields are provided
    if (!uid || !email || !token) {
      return res.status(400).json({ message: "Required fields are missing." });
    }
  
    try {
      // Check if the user exists in the database
      const existingUser = await this.dbService.getRecordsByFields(
        "dy_user",
        "*",
        `uid = ${db.escape(uid)}`
      );
  
      if (existingUser.length > 0) {
        // Extract role_id and fetch the corresponding role name
        const user = existingUser[0];
        const assignedRoleId = user.role_id;
  
        const roleResults = await this.dbService.getRecordsByFields(
          "st_role",
          "role",
          `id = ${db.escape(assignedRoleId)}`
        );
  
        const roleName = roleResults.length > 0 ? roleResults[0].role : null;
  
        if (!roleName) {
          return res.status(400).json({ message: "Invalid role_id. Role not found." });
        }
  
        // User already exists, return token and user details
        return res.status(200).json({
          message: "Login successful.",
          token,
          uid,
          role: roleName,
          id:user.id,
          email: user.email_id,
          username: user.user_name,
        });
      }
  
      // If user does not exist, create a new user
      const assignedRoleId = role_id || 2; // Default to role_id = 2 if not provided
  
      // Fetch the role name for the new user
      const roleResults = await this.dbService.getRecordsByFields(
        "st_role",
        "role",
        `id = ${db.escape(assignedRoleId)}`
      );
      const roleName = roleResults.length > 0 ? roleResults[0].role : null;
  
      if (!roleName) {
        return res.status(400).json({ message: "Invalid role_id. Role not found." });
      }
  
      // Prepare and add the new user to the database
      const fieldNames = "uid, user_name, email_id, mobile_no, role_id";
      const fieldValues = `${db.escape(uid)}, ${db.escape(displayName || null)}, ${db.escape(email)}, ${db.escape(mobile_no)}, ${db.escape(assignedRoleId)}`;
       await this.dbService.addNewRecord("dy_user", fieldNames, fieldValues);
      
      const usr = await this.dbService.getRecordsByFields(
        "dy_user",
        "*",
        `uid = ${db.escape(uid)}`
      );


      console.log("new user", usr);
      // Respond with success and return the generated token
      res.status(201).json({
        message: "User registered and logged in successfully.",
        token,
        uid,
        role: roleName,
        email,
        id:usr[0].id,
        username:displayName || null,
      });
    } catch (err) {
      console.error("Error during Google login:", err.message);
      res.status(500).json({ message: "Internal server error." });
    }
  }
  

  async login(req, res) {
    const { uid, token } = req.body;

    if (!uid) {
      return res.status(400).json({ message: "UID is required." });
    }

    try {
      const existingUser = await this.dbService.getRecordsByFields(
        "dy_user",
        "*",
        `uid = ${db.escape(uid)}`
      );

      if (existingUser.length === 0) {
        return res.status(404).json({ message: "User not found. Please signup first." });
      }

      const user = existingUser[0];
      const roleName = await this.fetchRoleName(user.role_id);
      if (!roleName) {
        return res.status(400).json({ message: "Invalid role_id. Role not found." });
      }

      res.status(200).json({
        message: "Login successful.",
        email: user.email_id,
        uid,
        token,
        role: roleName,
        id:user.id,
        username: user.user_name,
      });
    } catch (err) {
      console.error("Error during login:", err.message);
      res.status(500).json({ message: "Internal server error." });
    }
  }

  async blockUser(req, res) {
    const { uid } = req.params;

    if (!uid) {
      return res.status(400).json({ message: "UID is required." });
    }

    try {
      console.log(`Blocking user with UID: ${uid}`);
      return res.status(200).json({
        success: true,
        message: `User with UID ${uid} has been blocked.`,
      });
    } catch (err) {
      console.error("Error blocking user:", err.message);
      res.status(500).json({ message: "Internal server error." });
    }
  }

  async unblockUser(req, res) {
    const { uid } = req.params;

    if (!uid) {
      return res.status(400).json({ message: "UID is required." });
    }

    try {
      console.log(`Unblocking user with UID: ${uid}`);
      return res.status(200).json({
        success: true,
        message: `User with UID ${uid} has been unblocked.`,
      });
    } catch (err) {
      console.error("Error unblocking user:", err.message);
      res.status(500).json({ message: "Internal server error." });
    }
  }
}

module.exports = AuthController;