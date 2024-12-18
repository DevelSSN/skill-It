import { useState, useEffect } from "react";
import { useGoogleLogin, googleLogout } from "@react-oauth/google";
import styles from "./GoogleLoginComponent.module.css";

const GoogleLoginComponent = () => {
  const [user, setUser] = useState(null);
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  // Handle login
  const handleLogin = () => {
    // Redirect to your backend's Google login route
    window.location.href = "http://localhost:5000/auth/google"; // Backend handles the OAuth flow
  };

  // Handle logout
  const handleLogout = () => {
    // Clear user data and log out on the backend
    axios.post("http://localhost:5000/auth/logout")
      .then(() => {
        setUser(null);
        setIsLoggedIn(false);
      })
      .catch((error) => console.error("Logout Error: ", error));
  };

  // Check if the user is logged in (you can customize this based on your backend's session handling)
  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser)); // Parse and set user data from localStorage
      setIsLoggedIn(true);
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
