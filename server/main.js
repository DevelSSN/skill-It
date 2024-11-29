// app.js
const express = require('express');
const mysql = require('mysql2'); // For MySQL
const bodyParser = require('body-parser'); // To parse JSON body

const app = express();

// Parse incoming JSON requests
app.use(bodyParser.json());

// Create a MySQL connection
const db = mysql.createConnection({
  host: 'localhost',   // Replace with your database host
  user: 'root',        // Replace with your database user
  password: '',        // Replace with your database password
  database: 'your_database_name'  // Replace with your database name
});

// Connect to the database
db.connect((err) => {
  if (err) {
    console.error('Error connecting to database: ', err);
    return;
  }
  console.log('Connected to the database');
});

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

app.post('/search', (req, res) => {
  // Extract query parameters from the body of the request
  const { column, value } = req.body;

  // Sanitize input (be cautious about SQL injection)
  if (!column || !value) {
    return res.status(400).json({ error: 'Missing query parameters' });
  }

  // Build the SQL query
  const sqlQuery = `SELECT * FROM your_table WHERE ${column} = ?`;

  // Execute the SQL query
  db.execute(sqlQuery, [value], (err, results) => {
    if (err) {
      console.error('Error executing SQL query: ', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    // Return the result as JSON
    res.json(results);
  });
});

