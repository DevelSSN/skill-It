// import { useState } from "react";
import "./App.css";
import FormComponent from "./components/FormComponent/FormComponent";
import Profile from "./components/Profile/Profile";
import QueryResult from "./components/QueryResult/QueryResult";
import QuestionComponent from "./components/QuestionComponent/QuestionComponent";
import SearchList from "./components/SearchList/SearchList";

function App() {
  return (
    <>
      <div>
        <QuestionComponent />
        <FormComponent />
        <QueryResult />
        <SearchList />
        <Profile />
      </div>
    </>
  );
}

export default App;
