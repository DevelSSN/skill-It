const pool = require('./db');

(async () => {
  try {
    const [rows] = await pool.query('SELECT 1 + 1 AS result');
    console.log('Test Query Result:', rows);
  } catch (err) {
    console.error('Database Error:', err);
  }
})();
