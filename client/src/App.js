import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Redirect, Switch, Link } from "react-router-dom";
import BooksPage from './components/BooksPage'
import Header from './components/Header';
import './style/App.scss';


function App() {
  //login
  //signup
  //cart
  //orders
  //order
  //book
  //books

  //report pages tbd


  return (
    <div className="App">
      <Router>
          <Header/>
          <br></br>
          <br></br>
          <br></br>
          <br></br>
          <br></br>
          <Route path="/home" component={() => <BooksPage/>} />
       </Router>  
    </div>
  );
}

export default App;
