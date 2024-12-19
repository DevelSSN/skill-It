import { useState, useEffect } from "react";
import axios from "axios";
import styles from "./GoogleLoginComponent.module.css";

const GoogleLoginComponent = () => {
  const [user, setUser] = useState(null);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  // Handle login (Redirect to backend Google OAuth flow)
  const handleLogin = () => {
    const redirectUri = window.location.href; // Capture the current URL as redirect URI
    const loginUrl = `http://localhost:5000/auth/google?redirect_uri=${encodeURIComponent(redirectUri)}`;
    window.location.href = loginUrl; // Redirect to Google login
  };

  // Handle the Google callback after the user has logged in
  const handleGoogleCallback = () => {
    const urlParams = new URLSearchParams(window.location.search);
    const userDataString = urlParams.get("user");

    if (userDataString) {
      const userData = JSON.parse(decodeURIComponent(userDataString)); // Parse user data from query params
      localStorage.setItem("user", JSON.stringify(userData)); // Store user data in localStorage
      setUser(userData);
      setIsLoggedIn(true);
    }
  };

  // Handle logout
  const handleLogout = () => {
    axios
      .post("http://localhost:5000/auth/auth/logout")
      .then(() => {
        setUser(null);
        setIsLoggedIn(false);
        localStorage.removeItem("user"); // Clear user data from localStorage
      })
      .catch((error) => console.error("Logout Error: ", error));
  };

  // Check if the user is logged in and handle callback
  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser)); // Set user data from localStorage
      setIsLoggedIn(true);
    }

    // If the user is coming back from the Google callback
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has("user")) {
      // If the user data is in the query string, handle it
      handleGoogleCallback();
    }
  }, []);

  return (
    <div className={styles.googleLoginContainer}>
      <button
        onClick={isLoggedIn ? handleLogout : handleLogin}
        className={`${styles.navItem}`}
      >
        {isLoggedIn ? "Logout" : "Login with Google"}
      </button>

    </div>
  );
};

export default GoogleLoginComponent;
