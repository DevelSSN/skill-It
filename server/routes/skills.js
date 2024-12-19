const express = require('express');
const db = require('../db');

const router = express.Router();

// Add a new skill
router.post('/add', async (req, res) => {
  const { id, skills, experience } = req.body;

  // Ensure id and skills are provided
  if (!id || !skills || !experience) {
    return res.status(400).json({ error: "User ID, skills, and experience are required." });
  }

  try {
    // Start a transaction to ensure atomicity of operations
    const connection = await db.getConnection();
    await connection.beginTransaction();
    console.log("Conn Success");
    try {
      // Loop through each skill and add it if necessary
      for (let skillName of skills) {
        let skillId;

        // Check if the skill exists
        const [existingSkill] = await connection.query(
          "SELECT id FROM Skills WHERE skillName = ?",
          [skillName]
        );

        if (existingSkill.length > 0) {
          // If skill exists, use the existing ID
          skillId = existingSkill[0].id;
        } else {
          // If skill doesn't exist, insert it and get the new skill ID
          const [insertResult] = await connection.query(
            "INSERT INTO Skills (skillName) VALUES (?)",
            [skillName]
          );
          skillId = insertResult.insertId; // Get the newly inserted skill ID
        }

        // Insert the user-skill relationship into the Has table with experience
        await connection.query(
          "INSERT INTO Has (uid, sid, proficiencyLevel) VALUES (?, ?, ?)",
          [id, skillId, experience]
        );
      }

      // Commit the transaction
      await connection.commit();
      res.status(200).json({ message: "User skills and experience added successfully" });
    } catch (error) {
      // Rollback if any error occurs
      await connection.rollback();
      console.error("Error in transaction:", error);
      res.status(500).json({ error: "An error occurred while adding user skills" });
    } finally {
      // Release the connection back to the pool
      connection.release();
    }

  } catch (err) {
    console.error("Error getting connection:", err);
    res.status(500).json({ error: "Unable to get a database connection" });
  }
});
// Get all skills for a user
router.get('/user/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    const [rows] = await db.query('SELECT googleId, email, profilePhoto FROM Users JOIN Has ON Users.id = Has.uid WHERE Has.uid = ?', [userId]);
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
