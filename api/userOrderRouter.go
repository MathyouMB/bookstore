package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	//"sync"
	//"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

/*
func createUserOrder(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /userorders")
	var UserOrder Book
	if err := json.NewDecoder(r.Body).Decode(&book); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	
	_, err := db.Exec(`INSERT INTO books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`, book.ISBN, book.Book_title, book.Page_num, book.Book_price, book.Inventory_count, book.Restock_threshold, book.Book_genre, book.Publisher_sale_percentage, book.Publisher_id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode("Book Succesfully Created")
}
*/