
import React, { useEffect, useState } from 'react';
import '../style/Login.scss';
import {Link, Redirect} from "react-router-dom";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faBook} from '@fortawesome/free-solid-svg-icons'

function BookCreationPage(props) {
  const icon = <FontAwesomeIcon icon={faBook} />

  let [isbn,setIsbn] = useState("");
  let [bookTitle,setTitle] = useState("");
  let [pageNum,setPageNum] = useState("");
  let [bookPrice,setBookprice] = useState("");
  let [quantity,setQuantity] = useState("");
  let [restock,setRestock] = useState("");
  let [genre,setGenre] = useState("");
  let [percentage,setPercentage] = useState("");
  let [publisherId,setPubisherId] = useState("");
  let [expenditure,setExpenditure] = useState("");
  let [redirect, setRedirect] = useState(false);


  let handleInputChange = function(e){
    switch(e.target.name){
        case "isbn":
            setIsbn(e.target.value);
            break;
        case "title":
            setTitle(e.target.value);
            break;
        case "pageNum":
            setPageNum(e.target.value);
            break;
        case "price":
            setBookprice(e.target.value);
            break;
        case "quantity":
            setQuantity(e.target.value);
            break;
        case "restock":
            setRestock(e.target.value);
            break;
        case "genre":
            setGenre(e.target.value);
            break;
        case "percentage":
            setPercentage(e.target.value);
            break;
        case "id":
            setPubisherId(e.target.value);
            break;
        case "expenditure":
            setExpenditure(e.target.value);
            break;

        
      default:
        break;
  }
}


  const queryData = async () =>{

   const b = {
    "ISBN": isbn,
    "Book_title": bookTitle,
    "Page_num": parseInt(pageNum),
    "Book_price": parseFloat(bookPrice),
    "Inventory_count": parseInt(quantity),
    "Restock_threshold": parseInt(restock),
    "Book_Genre": genre,
    "Publisher_sale_percentage": parseFloat(percentage),
    "Publisher_id": parseInt(publisherId),
    "Hidden": false,
    "Expiture": parseFloat(expenditure)
   }

    const settings = {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify(b)
    };
    try {
        let fetchResponse = await fetch(`http://localhost:8080/books`, settings);
        let data = await fetchResponse.json();
        console.log(data);
        setRedirect(true)
    } catch (e) {
        return e;
    }    

  }

  const renderRedirect = () => {
    if (redirect) {
      return <Redirect to = {"/book/"+isbn} />
    }
  }
  
  return (
    <div className="login-page">
    {renderRedirect()}
    <div className="login-page-container">
      <div className="login-icon">
        {icon}
      </div>
      <br></br>
      <br></br>
      <div className="group">      
        <input className="login-input" name="isbn" type="text" value={isbn} placeholder="ISBN" onChange={handleInputChange} required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="title" type="text" value={bookTitle} placeholder="Title" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="pageNum" type="text" value={pageNum} placeholder="Number of Pages" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="price" type="text" value={bookPrice} placeholder="Price" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="quantity" type="text" value={quantity} placeholder="Current Quantity" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="restock" type="text" value={restock} placeholder="Restock Threshold" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="genre" type="text" value={genre} placeholder="Genre" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="percentage" type="text" value={percentage} placeholder="Publisher Sale Percentage" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="id" type="text" value={publisherId} placeholder="Publisher ID" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="expenditure" type="text" value={expenditure} placeholder="Expenditure" onChange={handleInputChange}  required></input>
      </div>

      <div className="wrapper">
        <div className="login-button" onClick={()=>{queryData()}}>Create</div>
      </div>
    </div>
    </div>
  );
}

export default BookCreationPage;
