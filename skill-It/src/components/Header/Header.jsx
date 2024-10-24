import React from "react";
import styles from "./Header.module.css";

const Header = () => {
  return (
    <header className={styles.header}>
      <div className={styles.logo}>Skill-It</div>
      <nav>
        <ul className={styles.navList}>
          <li>
            <a href="#" className={styles.navItem}>
              Contact
            </a>
          </li>
          <li>
            <a href="#" className={styles.navItem}>
              Jobs
            </a>
          </li>
          <li>
            <a href="#" className={styles.navItem}>
              Login
            </a>
          </li>
          <li>
            <a href="#" className={`${styles.navItem} ${styles.signUp}`}>
              Sign Up
            </a>
          </li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;
