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

module.exports = router;
