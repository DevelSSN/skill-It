import PropTypes from "prop-types";
import styles from "./Card.module.css";
function Card(props) {
  return (
    <div className={styles.card}>
      <img
        className={styles.cardImg}
        src="https://avatars.githubusercontent.com/u/140680675?v=4"
        alt="Profile Pic"
      />
      <h2 className={styles.cardTitle}>Name: {props.name}</h2>
      <p className={styles.cardDesc}>
        Age: {props.age}
        <br />
        Rate: {props.rate}
        <br />
        Job: {props.job}
        <br />
        Phone: {props.phone}
      </p>
    </div>
  );
}
Card.propTypes = {
  name: PropTypes.string,
  age: PropTypes.number,
  phone: PropTypes.number,
  rate: PropTypes.string,
  job: PropTypes.string,
};

Card.defaultProps = {
  name: "Guest",
  age: 0,
  phone: 1234567891,
  rate: "₹ 100",
  job: "Worker",
};
export default Card;
