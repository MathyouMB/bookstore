package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"github.com/gorilla/mux"
	"github.com/gorilla/handlers"
	_ "github.com/lib/pq"
)

const (
	hostname = "db" //localhost for local dev
	host_port = 5432
	username = "postgres"
	password = "1234"
	database_name = "3005BookStore"
)

var db *sql.DB
func testRequest(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /test")

	rows, err := db.Query("SELECT * FROM books")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var books []Book
	for rows.Next() {
		var book Book
		err := rows.Scan(&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Publisher_sale_percentage, &book.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		books = append(books, book)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(books[0].Book_title)

}
func init() {
	var err error
	pg_con_string := fmt.Sprintf("port=%d host=%s user=%s "+ "password=%s dbname=%s sslmode=disable", host_port, hostname, username, password, database_name)
	db, err = sql.Open("postgres", pg_con_string)
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	r := mux.NewRouter()
	//corsObj:=handlers.AllowedOrigins([]string{"*"})
	r.HandleFunc("/test", testRequest).Methods("GET")
	r.HandleFunc("/books", getBooks).Methods("GET")
	r.HandleFunc("/books/cart", getCartBooks).Methods("GET")
	r.HandleFunc("/books", createBook).Methods("POST")
	r.HandleFunc("/checkout", createBookCheckout).Methods("POST")
	r.HandleFunc("/checkout", getBookCheckouts).Methods("GET")
	r.HandleFunc("/books/{id}", getBook).Methods("GET")
	r.HandleFunc("/login", login).Methods("POST")
	http.Handle("/", r)
	fmt.Println("Server is running on port 8080")
	//http.ListenAndServe(":8080", r)
	http.ListenAndServe(":8080", handlers.CORS(handlers.AllowedHeaders([]string{"X-Requested-With", "Content-Type", "Authorization","Access-Control-Allow-Origin"}), handlers.AllowedMethods([]string{"GET", "POST", "PUT", "HEAD", "OPTIONS"}), handlers.AllowedOrigins([]string{"*"}))(r))
}