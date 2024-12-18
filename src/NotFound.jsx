// NotFound.jsx
import React from "react";
import styles from "./NotFound.module.css";
import Header from "./components/Header/Header";

const NotFound = () => {
  return (
    <div className="container">
      <Header />
      <div className={styles.notFound}>
        <h1>404</h1>
        <p>Oops! Page not found.</p>
        <p>It seems that the page you are looking for doesn't exist.</p>
        <a href="/" className={styles.homeLink}>
          Go back to Home
        </a>
      </div>
    </div>
  );
};

export default NotFound;
