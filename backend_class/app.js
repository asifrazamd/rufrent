/**
 * Main application file.
 * This file initializes the Express application, sets up middleware, and loads routes.
 */

const express = require('express'); // Importing the Express framework
const bodyParser = require('body-parser'); // Middleware for parsing request bodies
const tablesRoutes = require('./routes/tablesRoutes'); // Importing routes for table operations
const signupLoginRoutes = require('./routes/signupLoginRoutes'); // Importing routes for signup and login
const adminRoutes=require('./routes/adminRoutes');
const paymentRoutes = require('./routes/paymentRoutes'); // Importing routes for user operations
const cors = require('cors'); // Middleware for enabling Cross-Origin Resource Sharing (CORS)

const app = express(); // Creating an Express application instance

// Middleware to parse JSON request bodies
app.use(bodyParser.json()); // Automatically parses incoming JSON payloads and makes them available in req.body



// Middleware to enable CORS
app.use(cors()); // Allows requests from different origins, enabling cross-origin resource sharing

// Route handler for table-related operations
app.use('/api', tablesRoutes); // Routes starting with /api are handled by tablesRoutes

// Route handler for signup and login operations
app.use('/api', signupLoginRoutes); // Routes starting with /api are handled by signupLoginRoutes

app.use('/api',adminRoutes);

app.use('/api/payments',paymentRoutes);

// Start the server
const PORT = 5000; // Define the port number the server will listen on
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`); // Logs a message to indicate the server is running
});
