import PropTypes from "prop-types";

function Card(props) {
  return (
    <div className="card">
      <img
        className="card-img"
        src="https://avatars.githubusercontent.com/u/140680675?v=4https://via.placeholder.com/150"
        alt="Profile Pic"
      />
      <h2 className="card-title">Name: {props.name}</h2>
      <p className="card-desc">
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
