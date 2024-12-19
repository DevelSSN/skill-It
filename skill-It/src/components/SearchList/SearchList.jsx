import React, { useState, useEffect } from "react";
import styles from "./SearchList.module.css";
import Header from "../Header/Header";
import Card from "../Card/Card"; // Import the Card component

const SearchList = () => {
  const [searchTerm, setSearchTerm] = useState("");
  const [users, setUsers] = useState([]); // State to store the list of users
  const [filteredUsers, setFilteredUsers] = useState([]); // State for filtered users based on skill search

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
      fetch(`http://localhost:5000/search?skillName=${encodeURIComponent(searchTerm)}`)
        .then((response) => response.json())
        .then((data) => setFilteredUsers(data))
        .catch((error) => console.error("Error fetching data:", error));
    } else {
      setFilteredUsers(users); // If searchTerm is empty, reset to show all users
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
            <Card
              key={user.id || user.name} // Use user.id or fallback to user.name as the key
              name={user.name}
              age={Math.floor(Math.random() * 30) + 20} // Optional demo data
              rate={`₹ ${Math.floor(Math.random() * 100) + 50}`} // Corrected rate interpolation
              job="Skill Holder"
              phone={user.email || "No phone provided"} // Placeholder for phone
            />
          ))
        ) : (
          <div className={styles.noResults}>No results found</div>
        )}
      </div>
    </div>
  );
};

export default SearchList;
