import React, { useEffect, useState } from 'react';
import Book from './Book.js';

function Books() {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);

  const getBooks = async () => {
    let response = await fetch(`http://localhost:8080/books`);
    let data = await response.json()
    setData(data);
    setLoading(false);
  }

  useEffect(() => {
    if(loading){
        getBooks();
    }
  });

  return (
    <div className="books-page">
      {
        loading ? "Loading..."
        :
        data.map( item => (
            <Book book={item}/>
        ))
      
      }
    </div>
  );
}

export default Books;
