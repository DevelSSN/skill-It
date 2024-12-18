const express = require('express');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const db = require('../db');

const router = express.Router();

// Configure Google OAuth Strategy
passport.use(new GoogleStrategy({
  clientID: process.env.GOOGLE_CLIENT_ID,
  clientSecret: process.env.GOOGLE_CLIENT_SECRET,
  callbackURL: 'http://localhost:5000/auth/google/callback'
,
}, async (accessToken, refreshToken, profile, done) => {
  try {
    const { id: googleId, displayName: name, emails, photos } = profile;
    const email = emails[0].value;
    const profilePhoto = photos[0].value;

    // Check if user already exists in the database
    const [rows] = await db.query('SELECT * FROM Users WHERE googleId = ?', [googleId]);
    if (rows.length > 0) {
      return done(null, rows[0]); // User already exists
    } else {
      // Create a new user
      const [result] = await db.query(
        'INSERT INTO Users (googleId, email, name, profilePhoto) VALUES (?, ?, ?, ?)',
        [googleId, email, name, profilePhoto]
      );
      const [newUser] = await db.query('SELECT * FROM Users WHERE id = ?', [result.insertId]);
      return done(null, newUser);
    }
  } catch (err) {
    console.error(err);
    return done(err);
  }
}));

// Serialize user for session
passport.serializeUser((user, done) => {
  done(null, user.id);
});

// Deserialize user from session
passport.deserializeUser(async (id, done) => {
  try {
    const [rows] = await db.query('SELECT * FROM Users WHERE id = ?', [id]);
    done(null, rows[0]);
  } catch (err) {
    done(err);
  }
});

router.get("/google", (req, res, next) => {
  const redirectUri = req.query.redirect_uri || "http://localhost:5173"; // Default fallback
  req.session.redirectUri = redirectUri; // Store the redirect URI in session
  passport.authenticate("google", { scope: ["profile", "email"] })(req, res, next);
});

// Google OAuth callback route
router.get("/google/callback", passport.authenticate("google", { failureRedirect: "/" }), (req, res) => {
  // Get the stored redirect URI from session
  const redirectUri = req.session.redirectUri || "http://localhost:5173"; // Default fallback
  res.redirect(redirectUri); // Redirect the user to the dynamic URL
});

// Logout route
router.post("/auth/logout", (req, res) => {
  req.logout((err) => {
    if (err) return res.status(500).send("Logout failed");
    res.send("Logged out successfully");
  });
});

module.exports = router;
