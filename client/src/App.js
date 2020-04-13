import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Redirect, Switch, Link } from "react-router-dom";
import BooksPage from './components/BooksPage'
import BookPage from './components/BookPage'
import BooksManagementPage from './components/BookManagementPage'
import LoginPage from './components/LoginPage'
import CartPage from './components/CartPage'
import OrdersPage from './components/OrdersPage'
import Header from './components/Header';
import './style/App.scss';
import Orders from './components/OrdersPage';
import BookCreationPage from './components/BookCreationPage';
import ReportsPage from './components/ReportsPage';


function App() {
  //login
  //signup
  //cart
  //orders
  //order
  //book
  //books

  //report pages tbd

  let [user, setUser] = useState();
  const renderRedirect = () => {
    if (user == null) {
      return <Redirect to = {"/books"} />
    }
  }
  return (

    <div className="App">
      <Router>
          {renderRedirect()}
          <Header user={user}/>
          <br></br>
          <br></br>
          <br></br>
          <br></br>
          <br></br>
          <Route path="/books" component={() => <BooksPage user={user} />} />
          <Route path="/reports" component={() => <ReportsPage user={user} />} />
          <Route path="/createBook" component={() => <BookCreationPage user={user} />} />
          <Route path="/orders" component={() => <OrdersPage user={user} />} />
          <Route path="/book/:isbn" component={() => <BookPage user={user} />} />
          <Route path="/management" component={() => <BooksManagementPage user={user} />} />
          <Route path="/cart" component={() => <CartPage user={user}/>} />
          <Route path="/login" component={() => <LoginPage user={user} setUser={setUser}/>} />
          
       </Router>  
    </div>
  );
}

export default App;
