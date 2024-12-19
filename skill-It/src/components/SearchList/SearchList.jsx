import React, { useState, useEffect } from "react";
import styles from "./SearchList.module.css";
import Header from "../Header/Header";
import Card from "../Card/Card"; // Import the Card component

const SearchList = () => {
  const [searchTerm, setSearchTerm] = useState(""); // Search term entered by user
  const [users, setUsers] = useState([]); // State to store all users
  const [filteredUsers, setFilteredUsers] = useState([]); // State for filtered users based on search

  // Fetch all users initially when the component loads
  useEffect(() => {
    fetch("http://localhost:5000/users") // Assuming you have an endpoint for fetching all users
      .then((response) => response.json())
      .then((data) => {
        setUsers(data);
        setFilteredUsers(data); // Initially, show all users
      })
      .catch((error) => console.error("Error fetching users:", error));
  }, []);

  // Fetch users based on the skill search term
  useEffect(() => {
    if (searchTerm) {
      // Filter users based on skill search term
      const filtered = users.filter((user) =>
        // Ensure user.skills is a valid string before calling toLowerCase
        (user.skills && user.skills.toLowerCase().includes(searchTerm.toLowerCase()))
      );
      setFilteredUsers(filtered); // Set filtered users based on search
    } else {
      setFilteredUsers(users); // If no search term, show all users
    }
  }, [searchTerm, users]); // Run this effect whenever searchTerm or users change

  // Handle input change
  const handleSearchChange = (event) => {
    setSearchTerm(event.target.value);
  };

  return (
    <div className={styles.container}>
      <Header />
      <input
        type="text"
        placeholder="Search for a skill..."
        value={searchTerm}
        onChange={handleSearchChange}
        className={styles.searchInput}
      />
      <div className={styles.results}>
        {filteredUsers.length > 0 ? (
          filteredUsers.map((user) => (
            <a
              key={user.user_id || user.user_name}
              className={styles.anchor}
              href={`/profile?user=${user.user_id}`} // Assuming the user has a unique id for the profile
            >
              <div className={styles.itemList}>
                <Card
                  img={user.user_photo}
                  name={user.user_name}
                  rate={`₹ ${user.skill_rates}`} // Corrected rate interpolation
                  job={user.skills} // Display user skills
                  phone={user.user_email || "No email provided"} // Placeholder for phone/email
                />
              </div>
            </a>
          ))
        ) : (
          <div className={styles.noResults}>No results found</div>
        )}
      </div>
    </div>
  );
};

export default SearchList;
