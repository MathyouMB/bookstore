import React, { useEffect, useState } from 'react';
import BookRow from './BookRow';
import {Link, Redirect} from "react-router-dom";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faBook} from '@fortawesome/free-solid-svg-icons'
function BooksManagement(props) {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);
  const icon = <FontAwesomeIcon icon={faBook} />
  const getBooks = async () => {
    let response = await fetch(`http://localhost:8080/books/management`);
    let data = await response.json()
    setData(data);
    console.log(data)
    setLoading(false);
  }


  useEffect(() => {
    if(loading){
        if(props.user != null){
            getBooks();
        }
    }
  },[loading]);

  return (
    <div className="books-page">
        <div className="books-management">
        <div className="login-icon">
            {icon}
        </div>
        <Link to='/createBook'><div className="login-button" >Create Book</div></Link>
        <table>
        <tr className="book-row">
            <td>ISBN</td>
            <td>Title</td>
            <td>Inventory</td>
            <td>Restock Threshold</td>
            <td>Price</td>
            <td>Publisher Percentage</td>
            <td>Expenditure</td>
            <td>Hidden</td>
        </tr>
        {
        data.map( item => (
            <BookRow book={item} user={props.user}/>
        ))
        }
        </table>
        </div>
    </div>
  );
}

export default BooksManagement;
