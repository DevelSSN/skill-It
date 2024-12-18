import React, { useState } from "react";
import styles from "./SkillsForm.module.css";
import Header from "../Header/Header";

const SkillsForm = () => {
  const [skills, setSkills] = useState("");
  const [experience, setExperience] = useState("");
  const [rate, setRate] = useState("");
  const handleSubmit = async (e) => {
    e.preventDefault();
    const user=JSON.parse(localStorage.getItem("user"));
    const id=user.id;
    // Prepare the data to send to the backend
    const data = {
      id: id,
      skills: skills.split(",").map(skill => skill.trim()), // Assuming skills are separated by commas
      experience: parseInt(experience, 10),
      rate: parseInt(rate, 10)
    };

    try {
      // Send data to backend server
      const response = await fetch("http://localhost:5000/skills/add", {
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
        <label htmlFor="rate">Rate:</label>
        <input
          type="number"
          id="rate"
          name="rate"
          value={rate}
          onChange={(e) => setRate(e.target.value)}
          placeholder="e.g., 250"
        />
        <button type="submit" onClick={handleSubmit}>Submit</button>
      </form>
    </div>
  );
};

export default SkillsForm;
