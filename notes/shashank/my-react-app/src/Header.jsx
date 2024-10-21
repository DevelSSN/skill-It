import React from "react";
import Button from "./Button.jsx";
import styles from "./Header/Header.module.css";
function Header() {
  return (
    <header>
      <h1 className={styles.home}>My website</h1>
      <nav>
        <ul>
          <li className={styles.nav2}>
            <a href="#">About us</a>
          </li>
          <li className={styles.nav2}>
            <a href="#">Contact us</a>
          </li>
          <li className={styles.nav1}>
            <a href="#">Login</a>
          </li>
          <li className={styles.nav1}>
            <Button
              buttonClass={styles.button}
              buttonName="Signup"
              buttonContent="Signup"
            />
          </li>
        </ul>
      </nav>
    </header>
  );
}

export default Header;
