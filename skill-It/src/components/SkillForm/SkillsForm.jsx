import React, { useState } from "react";
import styles from "./SkillsForm.module.css";
import Header from "../Header/Header";

const SkillsForm = () => {
  const [skills, setSkills] = useState("");
  const [experience, setExperience] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Prepare the data to send to the backend
    const data = {
      googleId,
      skills: skills.split(",").map(skill => skill.trim()), // Assuming skills are separated by commas
      experience: parseInt(experience, 10),
    };

    try {
      // Send data to backend server
      const response = await fetch("https://your-backend-url.com/api/submitSkills", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });
    if (response.ok) {
        console.log("Skills submitted successfully!");
        // Optionally, you can display a success message or redirect
      } else {
        console.error("Failed to submit skills");
      }
    } catch (error) {
      console.error("Error submitting skills:", error);
    }
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

        <button type="submit" onClick={handleSubmit}>Submit</button>
      </form>
    </div>
  );
};

export default SkillsForm;
