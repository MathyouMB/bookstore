import React, { useEffect, useState } from 'react';
import '../style/Cart.scss';
import Book from './BookContainer.js';

function CartItem(props) {
    return (
        <div className="cart-item">
           <Book book={props.item} user={props.user} ordered={true}/>
        </div>
      );
}

function Cart(props) {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);

  const getCheckouts = async () => {
    let response = await fetch(`http://localhost:8080/books/cart?username=`+props.user.Username);
    let data = await response.json()
    setData(data);
    setLoading(false);
  }

  useEffect(() => {
    if(loading){
        getCheckouts();
    }
  });

  return (
    <div className="cart-page">
      {
        loading ? "Loading..."
        :
        data.map( item => (
            <CartItem item={item}/>
        ))
      
        }
    </div>
  );
}

export default Cart;
