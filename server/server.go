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
	Book_id       int      		`json:"id"`
	Book_title    string   		`json:"title"`
	Page_num      int     		`json:"page_num"`
	Book_price    float32     	`json:"price"`
}

var db *sql.DB

func GetBookHandler(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
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
	fmt.Println("Server is running on port 8080")
	http.ListenAndServe(":8080", r)
}