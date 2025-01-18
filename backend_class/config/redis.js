// Import the ioredis library, which is a Redis client for Node.js
const Redis = require('ioredis');

// Define a function to get the Redis URL from the environment variables
const getRedisUrl = () => {
  // Check if the REDIS_URL environment variable is set
  if (process.env.REDIS_URL) {
    // Return the Redis URL if it's set
    return process.env.REDIS_URL;
  }
  // Throw an error if the REDIS_URL environment variable is not set
  throw new Error("REDIS_URL is not defined");
};

// Create a new Redis client instance using the getRedisUrl function
const redis = new Redis(getRedisUrl());

// Export the Redis client instance as a module
module.exports = { redis };