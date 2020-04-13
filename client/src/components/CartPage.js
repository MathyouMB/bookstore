import React, { useEffect, useState } from 'react';
import {Link, Redirect} from "react-router-dom";
import '../style/Cart.scss';
import Book from './BookContainer.js';

function CartItem(props) {

    const RemoveFromCart = async () => {
        console.log("test")
        const b = {
            "Book_checkouts_id": props.book.Book_checkouts_id,
            "ISBN": props.book.ISBN,
            "Username":props.user.Username
        }
        console.log(b)
        console.log(props)
        console.log(props.book)
        const settings = {
            method: 'DELETE',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify(b)
        };
        try {
            let fetchResponse = await fetch(`http://localhost:8080/checkout`, settings);
            let data = await fetchResponse.json();
            props.setLoading(true);
        } catch (e) {
            return e;
        }    
   
      }

    return (
        <div className="cart-item">
           <Book book={props.book} user={props.user} ordered={true}/>
           <div className="book-details-grid">
               <br></br>
               <br></br>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Title</div>
                    <div className="book-details-grid-row-cell">{props.book.Book_title}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Genre</div>
                    <div className="book-details-grid-row-cell">{props.book.Book_genre}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">ISBN</div>
                    <div className="book-details-grid-row-cell">{props.book.ISBN}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Publisher</div>
                    <div className="book-details-grid-row-cell">{props.book.Publisher.Publisher_name}</div>
                </div>
                <div className="book-details-grid-row">
                    {
                    props.book.Authors != null &&
                    <div className="book-details-grid-row-cell">Authors</div>
                    }
                    <div className="book-details-grid-row-cell">
                    {
                    props.book.Authors != null &&       
                    <>
                        {   
                            props.book.Authors.map( author => (
                            <div>• {author.First_name} {author.Last_name}</div>
                            ))        
                        }  
                    </>
                    }
                    </div>
                </div>
                <br></br>
                <input type="button" className="cart-order-button" value="Remove" onClick={()=>{RemoveFromCart()}}></input>
            </div>
        </div>
      );
}

function Cart(props) {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);
  let[totalCost,setTotalCost] = useState(0);
  let [redirect, setRedirect] = useState(false);

  const getCheckouts = async () => {
    let response = await fetch(`http://localhost:8080/books/cart?username=`+props.user.Username);
    let data = await response.json()

    let s =0;
    if(data != null){  
        for(let i=0;i<data.length;i++){
            s+=data[0].Book_price;
        }
    }
    setTotalCost(s.toFixed(2));
    setData(data);
    setLoading(false);
  }

  const CreateOrder = async () => {
    console.log("order")

    let today = new Date(Date.now());

    let billingAddress = document.getElementById("billing-address").value;
    let creditcard = document.getElementById("creditcard").value;
    let cvs = document.getElementById("cvs").value;

    const order = {
        "Preferred_billing_address": (billingAddress.length < 1 ? props.user.Billing_address : billingAddress),
        "Preferred_credit_num": (creditcard.length < 1 ? props.user.Credit_card_number : creditcard),
        "Preferred_credit_cvs": (cvs.length < 1 ? props.user.Credit_card_cvs : cvs),
        "Order_day": today.getDate(),
        "Order_month": today.getMonth()+1,
        "Order_year": today.getFullYear(),
        "Total_paid": parseFloat(totalCost),
        "Tracking_status": "Order placed.",
        "Username": props.user.Username
    }

    const settings = {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify(order)
    };
    

    try {
        let fetchResponse = await fetch(`http://localhost:8080/order`, settings);
        let data = await fetchResponse.json();
        console.log(data)
        setRedirect(true)
    } catch (e) {
        console.log(e)
        return e;
    }    

  }

  useEffect(() => {
    if(loading && props.user != null){
        getCheckouts();
    }
  },[loading]);

  const renderRedirect = () => {
    if (redirect) {
      return <Redirect to = {"/orders"} />
    }
  }

  return (
    <div className="cart-page">
        {renderRedirect()}
      <div className="cart-page-summary">
        <div className="cart-page-summer-title">Order Summary</div>
        <hr></hr>
        {
        loading || data == null || data.length <=0 ? 
            <>
            <div className="cart-empty-text">Empty Cart</div>  
            {
                props.user != null ? "" :
                <div className="cart-empty-text">(Must be logged in)</div>
            }
            </>
        :
            <>
            {
                loading || data == null ? ""
                :
                data.map( item => (
                    <CartItem book={item} user={props.user} setLoading={setLoading}/>
                ))
            }
            <hr></hr>
            <div className="cart-page-row">
                <div className="cart-page-cell">Order Total:</div>
                <div className="cart-page-cell">${totalCost}</div>
            </div>
            <hr></hr>
            <div className="cart-checkout-input-wrapper">
                <br></br>
                <div className="cart-checkout-input-wrap"><input className="cart-checkout-input" id="billing-address" placeholder="Preferred Billing Address"></input></div>
                <div className="cart-checkout-input-wrap"><input className="cart-checkout-input" id="creditcard" placeholder="Preferred Credit Number"></input></div>
                <div className="cart-checkout-input-wrap"><input className="cart-checkout-input" id="cvs" placeholder="Preferred Credit CVS"></input></div>
            </div>
            <div className="cart-checkout-button" onClick={()=>{CreateOrder()}}>Checkout</div>
            </>
        }
      </div>
      
    </div>
  );
}

export default Cart;
