import React, { useEffect, useState } from 'react';
import '../style/Cart.scss';
import Book from './BookContainer.js';

function CartItem(props) {

    const RemoveFromCart = async () =>{
        console.log("test")
        const b = {
            "ISBN": props.book.ISBN,
            "Username":props.user.Username
        }
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
            //console.log(data);
            props.setLoading(true);
        } catch (e) {
            return e;
        }    
   
      }
    return (
        <div className="cart-item">
           <Book book={props.book} user={props.user} ordered={true}/>
           <div className="book-details-grid">
                <div className="book-details-heading"><h3>Details & Spec</h3></div>
                <hr></hr>
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
                    <div className="book-details-grid-row-cell">Authors</div>
                    <div className="book-details-grid-row-cell">
                    {
                    props.book.Authors == null ? "Loading..."
                    :        
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
                <input type="button" className="cart-order-button" value="Remove" onClick={()=>{RemoveFromCart()}}></input>
            </div>
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
    if(loading && props.user != null){
        getCheckouts();
    }
  },[loading]);

  return (
    <div className="cart-page">
      <div className="cart-page-summary">
        <div className="cart-page-summer-title">Order Summary</div>
        <hr></hr>
        {
        loading || data == null || data.length <=0 ? 
            <div className="cart-empty-text">Empty Cart</div>
        :
            <>
            <div className="cart-page-row">
                <div className="cart-page-cell">Items({"?"}):</div>
                <div className="cart-page-cell">$Money</div>
            </div>
            <div className="cart-page-row">
                <div className="cart-page-cell">Shipping and Handling:</div>
                <div className="cart-page-cell">$0</div>
            </div>
            <hr></hr>
            <div className="cart-page-row">
                <div className="cart-page-cell">Order Total:</div>
                <div className="cart-page-cell">$Big Money</div>
            </div>
            <div className="cart-checkout-button">Checkout</div>
            </>
        }
      </div>
      {
        loading || data == null ? ""
        :
        data.map( item => (
            <CartItem book={item} user={props.user} setLoading={setLoading}/>
        ))
      }
    </div>
  );
}

export default Cart;
