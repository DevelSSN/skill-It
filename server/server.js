require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const passport = require('passport');
const session = require('express-session');
const authRoutes = require('./routes/auth');
const skillsRoutes = require('./routes/skills');
const db = require("./db");

const app = express();
app.use(cors());
// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session Configuration
app.use(session({
  secret: process.env.GOOGLE_CLIENT_SECRET ,//Replace with a secure key
  resave: false,
  saveUninitialized: true,
}));

// Initialize Passport
app.use(passport.initialize());
app.use(passport.session());

// Routes
app.use('/auth', authRoutes);  // Google OAuth Routes
app.use('/skills', skillsRoutes);  // Skill Management Routes

// Start Server
const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

app.get("/search", (req, res) => {
  const skillName = req.query.skillName;
  const query = `
    SELECT u.id, u.name, u.email, u.profilePhoto, GROUP_CONCAT(s.skillName) AS skills
    FROM Users u
    JOIN Has h ON u.id = h.uid
    JOIN Skills s ON h.sid = s.id
    WHERE s.skillName = ?
    GROUP BY u.id;
  `;

  db.query(query, [skillName], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send("Error fetching data.");
      return;
    }
    res.json(results);
  });
});

app.get("/users", async(req,res) =>{
  try {
    const query = `
    SELECT 
    U.id AS user_id, 
    U.name AS user_name, 
    U.email AS user_email, 
    U.profilePhoto as user_photo,
    GROUP_CONCAT(DISTINCT S.skillName ORDER BY S.skillName ASC) AS skills,  
    GROUP_CONCAT(H.rate ORDER BY S.skillName ASC) AS skill_rates
FROM 
    Users U
LEFT JOIN 
    Has H ON U.id = H.uid
LEFT JOIN 
    Skills S ON H.sid = S.id
GROUP BY 
    U.id, U.name, U.email
ORDER BY 
    U.name ASC;  

  `;
    const [users] = await db.query(query);
    res.json(users);
  } catch (err) {
    res.status(500).send("Error fetching users.");
  }
});

app.get('/user/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    // Query to get user details along with associated skills and rates
    const [userRows] = await db.query(
      `
      SELECT 
        Users.id AS userId,
        Users.googleId,
        Users.email,
        Users.profilePhoto,
        Users.name,
        GROUP_CONCAT(Skills.skillName ORDER BY Skills.skillName ASC) AS skills,  -- Get all skills as a comma-separated list
        GROUP_CONCAT(Has.rate ORDER BY Skills.skillName ASC) AS skillRates  -- Get all rates for skills
      FROM Users
      JOIN Has ON Users.id = Has.uid
      JOIN Skills ON Skills.id = Has.sid
      WHERE Users.id = ?
      GROUP BY Users.id
      `,
      [userId]
    );

    // Check if user was found
    if (userRows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Send user data back to the frontend
    const user = userRows[0];
    res.json({
      userId: user.userId,
      googleId: user.googleId,
      email: user.email,
      profilePhoto: user.profilePhoto,
      name: user.name,
      skills: user.skills ? user.skills.split(',') : [],  // Split skills string into array
      skillRates: user.skillRates ? user.skillRates.split(',') : [],  // Split rates string into array
    });
  } catch (err) {
    console.error('Error fetching user data:', err);
    res.status(500).json({ error: 'Failed to fetch user details' });
  }
});
