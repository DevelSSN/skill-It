import PropTypes from "prop-types";
import styles from "./Card.module.css";
function Card(props) {
  return (
    <div className={styles.card}>
      <img
        className={styles.cardImg}
        src={props.img}
        alt="Profile Pic"
      />
      <h2 className={styles.cardTitle}>Name: {props.name}</h2>
      <p className={styles.cardDesc}>

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
  img: PropTypes.string,
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
