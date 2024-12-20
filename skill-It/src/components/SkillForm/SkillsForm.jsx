import React, { useState } from "react";
import styles from "./SkillsForm.module.css";
import Header from "../Header/Header";

const SkillsForm = () => {
  const [skills, setSkills] = useState("");
  const [experience, setExperience] = useState("");
  const [rate, setRate] = useState("");
  const handleSubmit = async (e) => {
    e.preventDefault();
    const userData = localStorage.getItem("user");
    console.log(userData);

    let id;

// Check if the user data exists in localStorage
    if (userData) {
      id = userData;
      try {
        // Try to parse the user data (assume it's stored as a JSON string)
        const user = JSON.parse(userData);

        // Check if user is just an id (only one key, 'id')
        if (user && Object.keys(user).length === 1 && user.id) {
          id = user.id; // User contains only an id
        }
        // Check if user is an object containing an id and other data
        else if (user && user.id) {
          id = user.id; // User is a full object with an id
        }
        else {
          console.error("User data is missing 'id' or is invalid.");
        }
      } catch (error) {
        // If parsing fails, it might be a plain string or an invalid format
        console.error("Error parsing user data:", error);
        // Check if the userData is just a raw ID (not an object, but a string or number)
      }
    } else {
      console.log("No user data found in localStorage.");
    }
    // console.log(id);
    // Prepare the data to send to the backend
    const data = {
      id: id,
      skills: skills.split(",").map(skill => skill.trim()), // Assuming skills are separated by commas
      experience: parseInt(experience, 10),
      rate: parseInt(rate, 10)
    };
    console.log(data);
    try {
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
