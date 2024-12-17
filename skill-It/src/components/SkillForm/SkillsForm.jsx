import React, { useState } from "react";
import styles from "./SkillsForm.module.css";
import Header from "../Header/Header";

const SkillsForm = () => {
  const [skills, setSkills] = useState("");
  const [experience, setExperience] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission logic here
    console.log("Skills:", skills);
    console.log("Experience:", experience);
  };

  return (
    <div className={styles.formContainer}>
      <Header />
      <h2>Enter Your Skills and Experience</h2>
      <p className={styles.instruction}>
        If you have more than one skill, please separate them with commas.
      </p>
      <form onSubmit={handleSubmit}>
        <label htmlFor="skills">Skills:</label>
        <input
          type="text"
          id="skills"
          name="skills"
          value={skills}
          onChange={(e) => setSkills(e.target.value)}
          placeholder="e.g., Java, Python, HTML"
        />

        <label htmlFor="experience">Years of Experience:</label>
        <input
          type="number"
          id="experience"
          name="experience"
          value={experience}
          onChange={(e) => setExperience(e.target.value)}
          placeholder="e.g., 2"
        />

        <button type="submit">Submit</button>
      </form>
    </div>
  );
};

export default SkillsForm;
