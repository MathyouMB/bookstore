import React, { useEffect, useState } from 'react';
import '../style/Cart.scss';

function CartItem(props) {
    return (
        <div className="cart-item">
          {props.item.Book_title}
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
