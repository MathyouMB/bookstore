package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

type Book struct {
	Id       int      `json:"id"`
	Title    string   `json:"title"`
}

var db *sql.DB

func GetBookHandler(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	rows, err := db.Query(`SELECT * FROM book WHERE id = $1`, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
	}
	var book Book
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&book.Id, &book.Title)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(book)
}

func init() {
	var err error
	db, err = sql.Open("postgres", "user=postgres password=1234 dbname=3005BookStore sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/books/{id}", GetBookHandler).Methods("GET")
	http.Handle("/", r)
	http.ListenAndServe(":8080", r)
}