const mysql = require('mysql2');

// Create a connection pool
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',        // Replace with your MySQL username
  password: '',        // Replace with your MySQL password
  database: 'SkillSharingPlatform',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

module.exports = pool.promise(); // Use promises for cleaner async/await usage
