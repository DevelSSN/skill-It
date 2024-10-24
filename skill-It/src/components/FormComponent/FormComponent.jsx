import Header from "../Header/Header";
import styles from "./FormComponent.module.css"; // Importing CSS Module

const FormComponent = () => {
  return (
    <div className={styles.container}>
      <Header />

      <form>
        <label htmlFor="job">Job:</label>
        <input
          type="text"
          id="job"
          name="job"
          placeholder="Enter job title"
          className={styles.input}
        />

        <label htmlFor="rate">Compensation:</label>
        <input
          type="text"
          id="rate"
          name="rate"
          placeholder="Enter rate"
          className={styles.input}
        />

        <label htmlFor="phone">Phone Number:</label>
        <input
          type="tel"
          id="phone"
          name="phone"
          placeholder="Enter phone number"
          className={styles.input}
        />

        <label htmlFor="email">Email:</label>
        <input
          type="email"
          id="email"
          name="email"
          placeholder="Enter your email"
          className={styles.input}
        />

        <label htmlFor="address">Address:</label>
        <textarea
          id="address"
          name="address"
          placeholder="Enter your address"
          className={styles.textarea}
        ></textarea>

        <div className={styles.buttonContainer}>
          <button type="button" className={styles.cancelButton}>
            Cancel
          </button>
          <button type="submit" className={styles.okButton}>
            OK
          </button>
        </div>
      </form>
    </div>
  );
};

export default FormComponent;
