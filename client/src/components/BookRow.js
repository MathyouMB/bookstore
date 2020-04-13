import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faShippingFast} from '@fortawesome/free-solid-svg-icons'
import { Link, Redirect } from "react-router-dom";
import CartItem from './CartItem.js';
import '../style/Book.scss';

function BookRow(props) {
    let[redirect, setRedirect] = useState(false);
    const flipBook = async (url) => {

        const settings = {
            method: 'PUT',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            }
        };

        let response = await fetch(url, settings);
        let data = await response.json()
    
        setRedirect(true)
      }

      const renderRedirect = () => {
        if (redirect) {
          return <Redirect to = {"/books"} />
        }
      }
    return (
        <tr className="book-row">
            {renderRedirect()}
            <td style={{"font-weight":"bold"}}><Link to={"/book/"+props.book.ISBN}>{props.book.ISBN}</Link></td>
            <td>{props.book.Book_title}</td>
            <td>{props.book.Inventory_count}</td>
            <td>{props.book.Restock_threshold}</td>
            <td>${props.book.Book_price}</td>
            <td>{props.book.Publisher_sale_percentage}%</td>
            <td>${props.book.Expenditure}</td>
            <td style={{"font-weight":"bold"}} onClick={()=>{flipBook("http://localhost:8080/books/hide/"+props.book.ISBN)}}>{(props.book.Hidden == false ? "False" : "True")}</td>
        </tr>
    );
}

export default BookRow;
