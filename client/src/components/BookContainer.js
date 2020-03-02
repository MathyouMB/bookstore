import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faBook} from '@fortawesome/free-solid-svg-icons'
import { Link } from "react-router-dom";
import '../style/Book.scss';

function BookCover(props) {

    const generateColor = () => {
        return '#' +  Math.random().toString(16).substr(-6);
    }  

    return (
        <div style={{"backgroundColor": generateColor()}} className="book-cover">
            <span className="book-cover-title">{props.title}</span>
        </div>
    );
}

function BookContainer(props) {
    return (
      <div className="book-container">
          <Link to={"book/"+props.book.ISBN}><BookCover title={props.book.Book_title}/></Link>
          <div className="book-title"><b>{props.book.Book_title}</b></div>
          <div className="book-genre">{props.book.Book_genre}</div>
          <div className="book-price"><b>${props.book.Book_price}</b></div>
          <input type="button" className="book-order-button" value="Add to Cart"></input>
      </div>
    );
  }
export default BookContainer;