package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)


func GetBooksHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Requested /books")
	rows, err := db.Query("SELECT * FROM book")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	defer rows.Close()
	var books []Book
	for rows.Next() {
		var book Book
		err := rows.Scan(&book.Book_id, &book.Book_title, &book.Page_num, &book.Book_price)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		books = append(books, book)
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(books)
}


func GetBookHandler(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	fmt.Println("Requested /books/"+ id)
	rows, err := db.Query(`SELECT * FROM book WHERE book_id = $1`, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
	}
	var book Book
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&book.Book_id, &book.Book_title, &book.Page_num, &book.Book_price)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(book)
	//we need error handling if there is no real book
}