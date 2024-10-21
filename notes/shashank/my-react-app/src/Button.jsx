import PropTypes from "prop-types";
import parse from "html-react-parser";
function Button(props) {
  return (
    <button className={props.buttonClass} name={props.buttonName}>
      {parse(props.buttonContent)}
    </button>
  );
}
export default Button;

Button.PropTypes = {
  buttonClass: String,
  buttonName: String,
  buttonContent: String,
};

Button.defaultProps = {
  buttonClass: "Generic",
  buttonName: "Generic",
  buttonContent: parse("Button"),
};
