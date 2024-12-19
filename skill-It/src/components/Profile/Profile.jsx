import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom"; // For extracting the query parameter
import styles from "./Profile.module.css";
import Header from "../Header/Header";

const Profile = () => {
  const [userData, setUserData] = useState(null); // State to store user data
  const [loading, setLoading] = useState(true); // Loading state
  const [error, setError] = useState(null); // Error state

  const location = useLocation(); // Access the location object to get the URL query params
  const userId = new URLSearchParams(location.search).get("user"); // Extract user ID from query string

  useEffect(() => {
    if (userId) {
      // Fetch the user data from API using the userId
      fetch(`http://localhost:5000/user/${userId}`) // Assuming the endpoint is like /users/:id
        .then((response) => response.json())
        .then((data) => {
          setUserData(data);
          setLoading(false);
        })
        .catch((error) => {
          setError("Failed to fetch user data");
          setLoading(false);
        });
    } else {
      setError("User ID not provided");
      setLoading(false);
    }
  }, [userId]);

  if (loading) {
    return <div className={styles.loading}>Loading...</div>;
  }

  if (error) {
    return <div className={styles.error}>{error}</div>;
  }

  if (!userData) {
    return <div className={styles.noData}>No data available for this user.</div>;
  }


  const handleCall = () => {
    window.location.href = `tel:${person.phone}`;
  };

  const handleEmail = () => {
    window.location.href = `mailto:example@example.com`; // Replace with actual email
  };

  const handleConfirmHired = () => {
    alert(`${userData.name} has been hired!`);
  };

  return (
    <div className={styles.container}>
      <Header />
      <div className={styles.profileContainer}>
        <img
          src={userData.profilePhoto}
          alt={`${userData.name}'s Profile`}
          className={styles.profilePic}
        />
        <h2 className={styles.name}>{userData.name}</h2>
       
        <p className={styles.info}>Phone: {userData.email}</p>
        <p className={styles.info}>Job: {`${userData.skills}`}</p>
        <p className={styles.info}>Compensation: {`₹${userData.skillRates}`}</p>
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
    </div>
  );
};

export default Profile;
