import React from "react";
import styles from "./Header.module.css";

const Header = () => {
  return (
    <header className={styles.header}>
      <div className={styles.logo}>
        <a className={styles.logo} href="/home">
          Skill-It
        </a>
      </div>
      <nav>
        <ul className={styles.navList}>
          <li>
            <a href="/contact" className={styles.navItem}>
              Contact
            </a>
          </li>
          <li>
            <a href="job" className={styles.navItem}>
              Jobs
            </a>
          </li>
          <li>
            <a href="login" className={styles.navItem}>
              Login
            </a>
          </li>
          <li>
            <a href="signup" className={`${styles.navItem} ${styles.signUp}`}>
              Sign Up
            </a>
          </li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;
