import PropTypes from "prop-types";
import styles from "./Card/Card.module.css";
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
        Lorem ipsum, dolor sit amet consectetur adipisicing elit. Age:{" "}
        {props.age}
      </p>
    </div>
  );
}
Card.propTypes = {
  name: PropTypes.string,
  age: PropTypes.number,
};

Card.defaultProps = {
  name: "Guest",
  age: 0,
};
export default Card;
