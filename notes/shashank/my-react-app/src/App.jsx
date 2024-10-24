import Food from "./Food";
import Footer from "./Footer";
import Header from "./Header";
import Card from "./Card";

function App() {
  return (
    <>
      <Header />
      <Card name="Shashank" age={19} />
      <Card name="Billy" age={16} />
      <Card name="Sumanth" age={19} />
      <Card />
      <Food />
      <Footer />
    </>
  );
}

export default App;
