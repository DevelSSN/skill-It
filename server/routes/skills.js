const express = require('express');
const db = require('../db');

const router = express.Router();

// Add a new skill
router.post('/add', async (req, res) => {
  const { userId, skillName, proficiencyLevel } = req.body;

  try {
    const [result] = await db.query(
      'INSERT INTO Skills (userId, skillName, proficiencyLevel) VALUES (?, ?, ?)',
      [userId, skillName, proficiencyLevel]
    );
    res.json({ message: 'Skill added successfully', skillId: result.insertId });
  } catch (err) {
    res.status(500).json({ error: 'Failed to add skill' });
  }
});

// Get all skills for a user
router.get('/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    const [rows] = await db.query('SELECT * FROM Skills WHERE userId = ?', [userId]);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch skills' });
  }
});

router.post("/addUser", (req, res) => {
  const profile = req.body.profile;

  // Check if the profile data exists
  if (!profile || !profile.sub || !profile.email) {
    return res.status(400).json({ error: "Invalid profile data" });
  }

  const { sub: googleId, email, name, profilePhoto} = profile;

  // Insert or Update User in Database
  const sql = `
    INSERT INTO Users (google_id, email, name, profilePhoto)
    VALUES (?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE 
      name = VALUES(name),
      picture = VALUES(picture)
  `;

  db.query( `
    INSERT INTO Users (google_id, email, name, profilePhoto)
    VALUES (?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE 
      name = VALUES(name),
      picture = VALUES(picture)
  `,
  [googleId, email, name, picture, locale], (err, result) => {
    if (err) {
      console.error("Error inserting/updating user:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.json({ message: "User added/updated successfully", result });
  });
});

module.exports = router;
