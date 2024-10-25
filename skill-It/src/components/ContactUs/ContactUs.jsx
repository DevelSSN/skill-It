import React from "react";
import styles from "./ContactUs.module.css";
import Header from "../Header/Header";

const ContactUs = () => {
  return (
    <div className={styles.container}>
      <Header />
      <h2>Get in Touch</h2>
      <form action="/submit" method="post">
        <label htmlFor="name">Name:</label>
        <input type="text" id="name" name="name" required />

        <label htmlFor="email">Email:</label>
        <input type="email" id="email" name="email" required />

        <label htmlFor="message">Message:</label>
        <textarea id="message" name="message" rows="5" required></textarea>

        <button type="submit">Send</button>
      </form>
    </div>
  );
};

export default ContactUs;
