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
    const [users] = await db.query('SELECT id, name, email FROM Users');
    res.json(users);
  } catch (err) {
    res.status(500).send("Error fetching users.");
  }
});