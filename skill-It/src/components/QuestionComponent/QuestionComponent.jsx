import React from "react";
import Header from "../Header/Header";
import styles from "./QuestionComponent.module.css";

const QuestionComponent = () => {
  return (
    <div className={styles.container}>
      <Header />
      <h1>WHAT WOULD YOU LIKE TO DO?</h1>
      <div className={styles.actions}>
        <a href="#" className={`${styles.btn} ${styles.apply}`}>
          Apply
        </a>
        <a href="#" className={`${styles.btn} ${styles.hire}`}>
          Hire
        </a>
      </div>
    </div>
  );
};

export default QuestionComponent;
