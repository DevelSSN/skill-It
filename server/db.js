const mysql = require('mysql2');
require('dotenv').config();

// Create a connection pool
const pool = mysql.createPool({
  host: '127.0.0.1',
  user: process.env.MYSQL_CRED_USER,        // Replace with your MySQL username
  password: process.env.MYSQL_CRED_PASS,        // Replace with your MySQL password
  database: 'SkillSharingPlatform',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

module.exports = pool.promise(); // Use promises for cleaner async/await usage
