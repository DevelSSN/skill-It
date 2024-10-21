import PropTypes from "prop-types";
import parse from "html-react-parser";
function Button(props) {
  return (
    <button
      className={props.buttonClass}
      name={props.buttonName}
      onClick={props.buttonWork}
    >
      {parse(props.buttonContent)}
    </button>
  );
}
export default Button;

Button.PropTypes = {
  buttonClass: String,
  buttonName: String,
  buttonContent: String,
  buttonWork: Function,
};

Button.defaultProps = {
  buttonClass: "Generic",
  buttonName: "Generic",
  buttonContent: parse("Button"),
  buttonWork: (event) => {
    event;
  },
};
