import React, { useState } from "react";
import styles from "./SearchList.module.css";
import Header from "../Header/Header";
import Card from "../Card/Card"; // Import the Card component

const SearchList = () => {
  // Predefined list of items
  const initialItems = [
    "Apple",
    "Banana",
    "Orange",
    "Mango",
    "Grapes",
    "Pineapple",
    "Strawberry",
    "Blueberry",
    "Watermelon",
    "Kiwi",
    "Cherry",
    "Pear",
    "Papaya",
    "Guava",
    "Lychee",
  ];

  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState(initialItems);

  // Filter items based on search term
  const filteredItems = items.filter((item) =>
    item.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Handle input change
  const handleSearchChange = (event) => {
    setSearchTerm(event.target.value);
  };

  return (
    <>
      <div className={styles.container}>
        <Header />
        <input
          type="text"
          placeholder="Search for an item..."
          value={searchTerm}
          onChange={handleSearchChange}
          className={styles.searchInput}
        />
        <div className={styles.results}>
          {filteredItems.length > 0 ? (
            filteredItems.map((item, index) => (
              <Card
                key={index}
                name={item}
                age={Math.floor(Math.random() * 30) + 20} // Random age for demo
                rate={`₹ ${Math.floor(Math.random() * 100) + 50}`} // Random rate for demo
                job="Fruit Seller"
                phone={1234567890 + index} // Simulated unique phone numbers
              />
            ))
          ) : (
            <div className={styles.noResults}>No results found</div>
          )}
        </div>
      </div>
    </>
  );
};

export default SearchList;
