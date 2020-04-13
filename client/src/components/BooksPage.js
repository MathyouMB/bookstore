import React, { useEffect, useState } from 'react';
import Book from './BookContainer.js';

function Books(props) {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState([]);
  let [initial, setInitial] = useState(false)
  const getBooks = async () => {
    let response = await fetch(`http://localhost:8080/books`);
    let data = await response.json()
    setData(data);
    setLoading(false);
    setInitial(true);
  }

  useEffect(() => {
    if(loading && !initial){
        getBooks();
    }
  });

  const search = async (event) => {
    console.log("search")
    setLoading(true)

    if(event.target.value.length < 1){
      getBooks()
    }else{
      let response = await fetch(`http://localhost:8080/books/search/`+event.target.value);
      let data = await response.json()
      setData(data);
      console.log(data)
      setLoading(false)
    }

  }

  return (
    <>
    <div className="books-search"><input className="books-search-input" type="text" placeholder="Search by ISBN, Book Title, Genre, or Author Name..."onChange={search}></input></div>
    <div className="books-page">
      {
        loading || data == null ? "No Results."
        :
        data.map( item => (
            <Book book={item} user={props.user}/>
        ))
      
      }
    </div>
    </>
  );
}

export default Books;
