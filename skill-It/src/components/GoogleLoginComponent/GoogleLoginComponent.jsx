import { useState } from "react";
import { useGoogleLogin, googleLogout } from "@react-oauth/google";
import axios from "axios";
import styles from "./GoogleLoginComponent.module.css";

const GoogleLoginComponent = () => {
  const [user, setUser] = useState(null);

  const login = useGoogleLogin({
    onSuccess: async (response) => {
      try {
        const tokenResponse = await axios.get(
          `https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=${response.credential}`,
        );

        const profile = tokenResponse.data;
        console.log("Login Success:", profile);

        // Send profile to your backend for DB integration
        await axios.post("http://your-server-endpoint/login", { profile });

        setUser(profile);
      } catch (error) {
        console.error("Error fetching Google profile:", error);
      }
    },
    onError: () => console.log("Login Failed"),
  });

  const logout = () => {
    googleLogout();
    setUser(null);
    console.log("User logged out");
  };

  return (
    <div className={styles.googleLoginContainer}>
      {user ? (
        <div className={styles.profile}>
          <img src={user.picture} alt="Profile" className={styles.profileImg} />
          <h3>Welcome, {user.name}</h3>
          <button
            onClick={logout}
            className={`${styles.navItem} ${styles.signUp}`}
          >
            Logout
          </button>
        </div>
      ) : (
        <button
          onClick={() => login()}
          className={`${styles.navItem} ${styles.signUp}`}
        >
          Login with Google
        </button>
      )}
    </div>
  );
};

export default GoogleLoginComponent;
