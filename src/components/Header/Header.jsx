import styles from "./Header.module.css";
import GoogleLoginComponent from "../GoogleLoginComponent/GoogleLoginComponent";

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
            <GoogleLoginComponent />
          </li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;
