import React, { useState } from "react";
import styles from "./SearchList.module.css";
import Header from "../Header/Header";

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
  ];

  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState(initialItems);

  // Filter items based on search term
  const filteredItems = items.filter((item) =>
    item.toLowerCase().includes(searchTerm.toLowerCase()),
  );

  // Handle input change
  const handleSearchChange = (event) => {
    setSearchTerm(event.target.value);
  };

  return (
    <>
      <div className={styles.container}>
        <div>
          <Header />
        </div>
        <input
          type="text"
          placeholder="Search for an item..."
          value={searchTerm}
          onChange={handleSearchChange}
          className={styles.searchInput}
        />
        <ul className={styles.itemList}>
          {filteredItems.length > 0 ? (
            filteredItems.map((item, index) => (
              <li key={index} className={styles.item}>
                {item}
              </li>
            ))
          ) : (
            <li className={styles.noResults}>No results found</li>
          )}
        </ul>
      </div>
    </>
  );
};

export default SearchList;
