require('dotenv').config();
const express = require('express');
const passport = require('passport');
const session = require('express-session');
const authRoutes = require('./routes/auth');
const skillsRoutes = require('./routes/skills');

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session Configuration
app.use(session({
  secret: 'your-secret-key', // Replace with a secure key
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
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
