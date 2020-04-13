import React, { useEffect, useState } from 'react';
import Order from './Order.js';

function Orders(props) {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);

  const getOrders = async () => {
    let response = await fetch(`http://localhost:8080/order?username=`+props.user.Username);
    let data = await response.json()
    setData(data);
    console.log(data)
    setLoading(false);
  }

  useEffect(() => {
    if(loading){
        if(props.user != null){
            getOrders();
        }
    }
  },[loading]);

  return (
    <div className="books-page">
      
        {
        loading || data == null || data.length <=0 ? 
            <>
            <div className="cart-empty-text">No orders</div>  
            {
                props.user != null ? "" :
                <div className="cart-empty-text">(Must be logged in)</div>
            }
            </>
        :
            <>
                {
                data.map( item => (
                    <Order order={item} user={props.user}/>
                ))
                }
            </>
        }
    </div>
  );
}

export default Orders;
