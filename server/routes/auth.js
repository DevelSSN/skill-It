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

// Login Route
router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

// OAuth Callback Route
router.get('/google/callback',
  passport.authenticate('google', {
    failureRedirect: '/login',
    successRedirect: '/dashboard',
  })
);

module.exports = router;
