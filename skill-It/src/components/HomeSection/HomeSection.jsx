// HomeSection.jsx
import React from "react";
import styles from "./HomeSection.module.css";
import homeImage from "./new.png"; // Ensure the image is in the correct path
import Header from "../Header/Header";

const HomeSection = () => {
  return (
    <body>
      <Header />
      <main>
        <section className={styles.home}>
          <div className={styles.homeText}>
            <h1>Unlock Your Future</h1>
            <p>Find the Job You Deserve Today!</p>
            <p>
              Explore numerous open positions and find your perfect fit today!
            </p>
            <div className={styles.ctaButtons}>
              <a href="#" className={`${styles.btn} ${styles.learnMore}`}>
                Learn More
              </a>
              <a href="#" className={`${styles.btn} ${styles.getStarted}`}>
                Get Started
              </a>
            </div>
          </div>
          <div className={styles.homeImage}>
            <img
              src={homeImage}
              width="600"
              height="400"
              alt="Illustration of person working"
            />
          </div>
        </section>
      </main>
    </body>
  );
};

export default HomeSection;
