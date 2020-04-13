import React, { useEffect, useState } from 'react';
import '../style/Cart.scss';
import Book from './BookContainer.js';

function CartItem(props) {

    return (
        <div className="cart-item">
           <Book book={props.book} user={props.user} ordered={true}/>
           <div className="book-details-grid">
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
                <div className="margin-center"></div>
            </div>
        </div>
      );
}

export default CartItem;