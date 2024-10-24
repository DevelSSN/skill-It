import Card from "../Card/Card";
import Header from "../Header/Header";
import styles from "./QueryResult.module.css";

const QueryResult = () => {
  return (
    <>
      <div className={styles.container}>
        <Header />
        <div className={styles.result}>
          <Card />
          <Card />
        </div>
      </div>
    </>
  );
};
export default QueryResult;
