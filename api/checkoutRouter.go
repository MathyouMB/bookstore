package main

import (
	"encoding/json"
	"net/http"
	"fmt"
//	"sync"
//	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

type BookCheckoutBody struct {
	Book_checkouts_id  int `json:"Book_checkouts_id"`
	ISBN		string  `json:"ISBN"`
	Username 	string	`json:"Username"`
}

func getBookCheckouts(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /checkout")
	keys, ok := r.URL.Query()["username"]
	query_string := "SELECT * FROM book_checkouts"

    if !ok || len(keys[0]) < 1 {
		fmt.Println("Url Param 'username' is missing")
	}
	fmt.Println(keys)
	if(ok){
		query_string = "SELECT * FROM book_checkouts WHERE username = '"+keys[0]+"'";
	}

	rows, err := db.Query(query_string)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var checkouts []BookCheckout
	for rows.Next() {
		var checkout BookCheckout

		err := rows.Scan(&checkout.Book_checkouts_id , &checkout.ISBN, &checkout.Username)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		checkouts = append(checkouts, checkout)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")

	if(ok){
		json.NewEncoder(w).Encode(checkouts)
	}else{
		json.NewEncoder(w).Encode("No Username Specified")
	}
}

func createBookCheckout(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /checkout")
	var body BookCheckoutBody

	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Println(body.Username)

	_, err := db.Exec(`INSERT INTO book_checkouts (isbn, username) VALUES ($1, $2)`, body.ISBN, body.Username)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode("Book Checkout Succesfully Created")
}

func deleteBookCheckout(w http.ResponseWriter, r *http.Request) {

	fmt.Println("DELETE /checkout")
	var body BookCheckoutBody

	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Println(body.ISBN)

	_, err := db.Exec(`DELETE FROM book_checkouts WHERE book_checkouts_id = $1`, body.Book_checkouts_id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode("Book Checkout Succesfully removefrom cart")
}
