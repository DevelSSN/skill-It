import React from "react";
import styles from "./Profile.module.css";
import profile from "./profile.png";
const Profile = (props) => {
  const person = {
    name: "John Doe",
    age: 30,
    phone: "123-456-7890",
    job: "Software Engineer",
    compensation: "$100,000",
    profilePic: { profile }, // Placeholder image
  };

  const handleCall = () => {
    window.location.href = `tel:${person.phone}`;
  };

  const handleEmail = () => {
    window.location.href = `mailto:example@example.com`; // Replace with actual email
  };

  const handleConfirmHired = () => {
    alert(`${person.name} has been hired!`);
  };

  return (
    <div className={styles.container}>
      <img
        src={person.profilePic}
        alt={`${person.name}'s Profile`}
        className={styles.profilePic}
      />
      <h2 className={styles.name}>{person.name}</h2>
      <p className={styles.info}>Age: {person.age}</p>
      <p className={styles.info}>Phone: {person.phone}</p>
      <p className={styles.info}>Job: {person.job}</p>
      <p className={styles.info}>Compensation: {person.compensation}</p>
      <div className={styles.buttons}>
        <button className={styles.emailButton} onClick={handleEmail}>
          Email
        </button>
        <button className={styles.callButton} onClick={handleCall}>
          Call
        </button>
      </div>
      <button className={styles.hireButton} onClick={handleConfirmHired}>
        Confirm Hired
      </button>
    </div>
  );
};

export default Profile;
