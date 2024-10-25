// import { useState } from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import "normalize.css";
import "./App.css";
import FormComponent from "./components/FormComponent/FormComponent";
import Profile from "./components/Profile/Profile";
import QueryResult from "./components/QueryResult/QueryResult";
import QuestionComponent from "./components/QuestionComponent/QuestionComponent";
import SearchList from "./components/SearchList/SearchList";
import HomeSection from "./components/HomeSection/HomeSection";
import NotFound from "./NotFound";
import ContactUs from "./components/ContactUs/ContactUs";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomeSection />} />
        <Route path="/home" element={<HomeSection />} />
        <Route path="job" element={<QuestionComponent />} />
        <Route path="contact" element={<ContactUs />} />
        <Route path="result" element={<QueryResult />} />
        <Route path="search" element={<SearchList />} />
        <Route path="profile" element={<Profile />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
