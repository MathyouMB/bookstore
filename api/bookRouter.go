package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	"sync"
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

func getBooks(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books")
	keys, ok := r.URL.Query()["genre"]
	query_string := "SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false"

    if !ok || len(keys[0]) < 1 {
		fmt.Println("Url Param 'genre' is missing")
	}
	fmt.Println(keys)
	if(ok){
		query_string = "SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false AND book_genre = '"+keys[0]+"'";
	}

	rows, err := db.Query(query_string)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var books []Book
	for rows.Next() {
		var book Book

		err := rows.Scan(&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Book_genre, &book.Publisher_sale_percentage, &book.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		var wg sync.WaitGroup

		wg.Add(2)

		go queryPublisher(w, book.Publisher_id, &book.Publisher, &wg)
		go queryAuthors(w, book.ISBN, &book.Authors, &wg)

		wg.Wait()

		books = append(books, book)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(books)
}

type CartBook struct {
	Book_checkouts_id       	  		int        		`json:"Book_checkouts_id"`
	ISBN       	  						string          `json:"ISBN"`
	Book_title    						string   		`json:"Book_title"`
	Page_num      						int     		`json:"Page_num"`
	Book_price    						float32     	`json:"Book_price"`
	Inventory_count     				int     		`json:"Inventory_count"`
	Restock_threshold   				int     		`json:"Restock_threshold"`
	Book_genre    						string     		`json:"Book_genre"`
	Publisher_sale_percentage    		float32     	`json:"Publisher_sale_percentage"`
	Publisher_id   						int     		`json:"Publisher_id"`
	Publisher  							Publisher 		`json:"Publisher"`
	Authors  							[]Author 		`json:"Authors"`

}

func getCartBooks(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books/cart")
	keys, ok := r.URL.Query()["username"]
	query_string := "SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false"

    if !ok || len(keys[0]) < 1 {
		fmt.Println("Url Param 'genre' is missing")
	}
	fmt.Println(keys)
	if(ok){
		query_string = "SELECT book_checkouts_id, isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books left outer join book_checkouts using (ISBN) WHERE username = '"+keys[0]+"' AND hidden = false";
	}

	rows, err := db.Query(query_string)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var books []CartBook
	for rows.Next() {
		var book CartBook

		err := rows.Scan(&book.Book_checkouts_id,&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Book_genre, &book.Publisher_sale_percentage, &book.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		var wg sync.WaitGroup

		wg.Add(2)

		go queryPublisher(w, book.Publisher_id, &book.Publisher, &wg)
		go queryAuthors(w, book.ISBN, &book.Authors, &wg)

		wg.Wait()

		books = append(books, book)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	if(ok){
		json.NewEncoder(w).Encode(books)
	}else{
		json.NewEncoder(w).Encode("No Username Specified")
	}
}


func getBook(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	fmt.Println("GET /books/"+ id)
	rows, err := db.Query(`SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE isbn = $1`, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
	}
	var book Book
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Book_genre, &book.Publisher_sale_percentage, &book.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	var wg sync.WaitGroup

	wg.Add(2)

	go queryPublisher(w, book.Publisher_id, &book.Publisher, &wg)
	go queryAuthors(w, book.ISBN, &book.Authors, &wg)

	wg.Wait()

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")

	if (len(book.ISBN) <= 0){
		json.NewEncoder(w).Encode("Error: Invalid ISBN: "+id)
		fmt.Println("Error: Invalid ISBN: "+id)
	}else{
		json.NewEncoder(w).Encode(book)
	}

}

func hideBook(w http.ResponseWriter, r *http.Request) {
	id := mux.Vars(r)["id"]
	fmt.Println("PUT /books/hide/"+ id)

	db.Exec(`UPDATE books SET hidden = NOT hidden WHERE isbn = $1`, id)

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode("Updated.")
}

func createBook(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /books")
	var book Book
	if err := json.NewDecoder(r.Body).Decode(&book); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	
	_, err := db.Exec(`INSERT INTO books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`, book.ISBN, book.Book_title, book.Page_num, book.Book_price, book.Inventory_count, book.Restock_threshold, book.Book_genre, book.Publisher_sale_percentage, book.Publisher_id, book.Hidden, book.Expenditure)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode("Book Succesfully Created")
}

func queryPublisher(w http.ResponseWriter, id int, p *Publisher, wg *sync.WaitGroup){
	
	defer wg.Done()
	book_publisher, err := db.Query(`SELECT * FROM publishers WHERE publisher_id = $1`, id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	defer book_publisher.Close()

	for book_publisher.Next() {
		var publisher Publisher
		err := book_publisher.Scan(&publisher.Publisher_id, &publisher.Publisher_name)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		*p = publisher
	}
}
func queryAuthors(w http.ResponseWriter, isbn string, a *[]Author, wg *sync.WaitGroup){
	
	defer wg.Done()
	book_authors, err := db.Query(`SELECT author_id, first_name, last_name, artist_name, authors.publisher_id FROM (authors join book_authors using(author_id)) left outer join books using (isbn) WHERE isbn = $1`, isbn)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	defer book_authors.Close()

	for book_authors.Next() {
		var author Author
		err := book_authors.Scan(&author.Author_id, &author.First_name, &author.Last_name, &author.Artist_name, &author.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		*a = append(*a, author)
	}
}

func getBooksSearch(w http.ResponseWriter, r *http.Request) {
	search := mux.Vars(r)["search"]
	fmt.Println("GET /books/search/"+ search)

	search_results, err := db.Query(`SELECT DISTINCT isbn FROM books JOIN book_authors USING(isbn) JOIN authors USING(author_id) WHERE isbn LIKE $1 OR book_title LIKE $1 OR book_genre LIKE $1 OR first_name LIKE $1 OR last_name LIKE $1 AND hidden = false`, search+"%")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer search_results.Close()
	var books []Book
	for search_results.Next() {
		
		var isbn string
		search_results.Scan(&isbn)
		
		var book Book
		
		queryBookByISBN(w,r,&book,isbn)

		books = append(books, book)

	}

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(books)
}

func queryBookByISBN(w http.ResponseWriter, r *http.Request, b *Book, isbn string) {
	
	rows, err := db.Query(`SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE isbn = $1`, isbn)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
	}
	var book Book
	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Book_genre, &book.Publisher_sale_percentage, &book.Publisher_id)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	var wg sync.WaitGroup

	wg.Add(2)

	go queryPublisher(w, book.Publisher_id, &book.Publisher, &wg)
	go queryAuthors(w, book.ISBN, &book.Authors, &wg)

	wg.Wait()

	*b = book

}

func getBooksManagement(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books/management")

	rows, err := db.Query("SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure FROM books")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var books []Book
	for rows.Next() {
		var book Book

		err := rows.Scan(&book.ISBN, &book.Book_title, &book.Page_num, &book.Book_price, &book.Inventory_count, &book.Restock_threshold, &book.Book_genre, &book.Publisher_sale_percentage, &book.Publisher_id, &book.Hidden, &book.Expenditure)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		books = append(books, book)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(books)
}
type SaleByGenre struct {
	Book_genre    					string     		`json:"Book_genre"`
	Count   						int     		`json:"Count"`
}
func getSalesByGenre(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books/salebygenre")

	rows, err := db.Query("SELECT book_genre, COUNT(book_genre) FROM user_ordered_books LEFT JOIN books USING (isbn) GROUP BY book_genre")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var entrys []SaleByGenre
	for rows.Next() {
		var entry SaleByGenre

		err := rows.Scan(&entry.Book_genre, &entry.Count)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		entrys = append(entrys, entry)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(entrys)
}

type SaleByAuthor struct {
	First_name    					string     		`json:"First_name"`
	Last_name    					string     		`json:"Last_name"`
	Count   						int     		`json:"Count"`
}
func getSalesByAuthor(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books/salebygenre")

	rows, err := db.Query("SELECT authors.first_name, authors.last_name, COUNT(authors.author_id) FROM user_ordered_books LEFT JOIN book_authors USING (isbn) JOIN authors USING (author_id) GROUP BY(authors.author_id)")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var entrys []SaleByAuthor
	for rows.Next() {
		var entry SaleByAuthor

		err := rows.Scan(&entry.First_name,&entry.Last_name, &entry.Count)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		entrys = append(entrys, entry)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(entrys)
}


type BookPriceExpenditure struct {
	ISBN       	  						string        `json:"ISBN"`
	Book_title    						string   		`json:"Book_title"`
	Book_price    						float32     	`json:"Book_price"`
	Expenditure   						float32     	`json:"Expenditure"`
}

func getPriceVsExpenditure(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /books/getpricevsexpenditure")

	rows, err := db.Query("SELECT isbn, book_title, book_price, expenditure FROM books")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var entrys []BookPriceExpenditure
	for rows.Next() {
		var entry BookPriceExpenditure

		err := rows.Scan(&entry.ISBN, &entry.Book_title, &entry.Book_price, &entry.Expenditure)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		entrys = append(entrys, entry)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(entrys)
}

