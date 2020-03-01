import React, { useEffect, useState } from 'react';
import Book from './BookContainer.js';
import '../style/Book.scss';

function BookPage() {
  let[loading, setLoading] = useState(true);
  let[data, setData] = useState();

  const getBook = async () => {
    const urlParams = new URLSearchParams(window.location.search);
    let idParam = urlParams.get('ID');
    let response = await fetch(`http://localhost:8080/books/`+idParam);
    let data = await response.json()
    
    setData(data);
    setLoading(false);
  }

  useEffect(() => {
    if(loading){
        getBook();
    }
  });

  return (
    <div className="books-page-single">
      {
        loading ? "Loading..."
        :        
        <>
        <Book book={data}/>

        <div className="book-details">
            <div className="book-details-container">
            <div className="book-details-grid">
                <div className="book-details-heading"><h3>Details & Spec</h3></div>
                <hr></hr>
                <br></br>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Title</div>
                    <div className="book-details-grid-row-cell">{data.Book_title}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Genre</div>
                    <div className="book-details-grid-row-cell">{data.Book_genre}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">ISBN</div>
                    <div className="book-details-grid-row-cell">{data.ISBN}</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Publisher</div>
                    <div className="book-details-grid-row-cell">...</div>
                </div>
                <div className="book-details-grid-row">
                    <div className="book-details-grid-row-cell">Authors</div>
                    <div className="book-details-grid-row-cell">...</div>
                </div>
            </div>
            </div>
        </div>
        </>
        }
    </div>
  );
}

export default BookPage;
