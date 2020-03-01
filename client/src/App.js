import React, { useEffect, useState } from 'react';
import './App.scss';


function App() {
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
    <div className="App">
      {
        loading ? "Loading..."
        :
        data.map( item => (
            <div>{item.Book_title}</div>
        ))
      
      }
    </div>
  );
}

export default App;
