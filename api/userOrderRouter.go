
package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	"time" 
	"sync"
	_ "github.com/lib/pq"
)

type BookCheckoutScan struct {
	Book_checkouts_id   int `json:"Book_checkouts_id"`
	ISBN				string  `json:"ISBN"`
}

type BookInventoryScan struct {
	Inventory_count     				int     		`json:"Inventory_count"`
	Restock_threshold   				int     		`json:"Restock_threshold"`
	Publisher_id   						int     		`json:"Publisher_id"`
	Book_price    						float32     	`json:"Book_price"`
	Publisher_sale_percentage    		float32     	`json:"Publisher_sale_percentage"`
}

	

func createUserOrder(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /order")
	var order UserOrder
	if err := json.NewDecoder(r.Body).Decode(&order); err != nil {
		fmt.Println(err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	var user_order_id int
	err := db.QueryRow(`INSERT INTO user_orders (preferred_billing_address, preferred_credit_num, preferred_credit_cvs, order_day, order_month, order_year, total_paid, tracking_status, username) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING user_order_id`, order.Preferred_billing_address, order.Preferred_credit_num, order.Preferred_credit_cvs, order.Order_day, order.Order_month, order.Order_year, order.Total_paid, order.Tracking_status, order.Username).Scan(&user_order_id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Println(order.Username)
	fmt.Println(user_order_id)

	cart, err := db.Query(`SELECT book_checkouts_id,isbn FROM book_checkouts WHERE username = $1`, order.Username)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	
	defer cart.Close()

	for cart.Next() {

		var checkout BookCheckoutScan
		
		err := cart.Scan(&checkout.Book_checkouts_id, &checkout.ISBN)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		fmt.Println(checkout.Book_checkouts_id)
		fmt.Println(checkout.ISBN)

		db.Exec(`INSERT INTO user_ordered_books (isbn, user_order_id) VALUES ($1, $2)`, checkout.ISBN, user_order_id)
		db.Exec(`DELETE FROM book_checkouts WHERE book_checkouts_id = $1`, checkout.Book_checkouts_id)
		db.Exec(`UPDATE books SET inventory_count = inventory_count - 1 WHERE isbn = $1`, checkout.ISBN)


		inventory_info, err := db.Query(`SELECT inventory_count, restock_threshold, publisher_id, book_price, publisher_sale_percentage FROM books WHERE isbn = $1`, checkout.ISBN)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		defer inventory_info.Close()
		for inventory_info.Next() {
			var book_inventory_info BookInventoryScan
			inventory_info.Scan(&book_inventory_info.Inventory_count, &book_inventory_info.Restock_threshold, &book_inventory_info.Publisher_id,&book_inventory_info.Book_price, &book_inventory_info.Publisher_sale_percentage)
			fmt.Println(book_inventory_info.Inventory_count)
			fmt.Println(book_inventory_info.Restock_threshold)
			

			db.Exec(`UPDATE bank_accounts SET account_balance = account_balance + $2 WHERE publisher_id = $1`, book_inventory_info.Publisher_id, book_inventory_info.Book_price*book_inventory_info.Publisher_sale_percentage)

			orderExists := false
			if(book_inventory_info.Inventory_count <= book_inventory_info.Restock_threshold){
				var orders int
				row := db.QueryRow(`SELECT COUNT(isbn) FROM store_orders WHERE isbn = $1`,checkout.ISBN)
				err := row.Scan(&orders)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}

				if(orders > 0){
					orderExists = true
				}
			}else{
				orderExists = true
			}

			if(orderExists == false){
				currentTime := time.Now()    

				var count int
				row := db.QueryRow(`SELECT COUNT(order_month) FROM user_ordered_books LEFT JOIN user_orders USING (user_order_id) WHERE order_month = $1 AND isbn = $2`, currentTime.Month(), checkout.ISBN)
				err := row.Scan(&count)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}
				fmt.Println("Books this month")
				fmt.Println(count)


				emailText := "Hello, we have made a new book order. Thanks!"
				db.Exec(`INSERT INTO store_orders (book_quantity, email_text, isbn, publisher_id) VALUES ($1, $2, $3, $4)`, count, emailText, checkout.ISBN, book_inventory_info.Publisher_id)

				
			}

		}

			
	}

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(user_order_id)
}

func getUserOrders(w http.ResponseWriter, r *http.Request) {
	fmt.Println("GET /order")
	keys, ok := r.URL.Query()["username"]
	query_string := "SELECT * FROM user_orders"

    if !ok || len(keys[0]) < 1 {
		fmt.Println("Url Param 'username' is missing")
	}
	fmt.Println(keys)
	if(ok){
		query_string = "SELECT * FROM user_orders WHERE username = '"+keys[0]+"'";
	}

	rows, err := db.Query(query_string)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}

	defer rows.Close()
	var orders []UserOrder
	for rows.Next() {
		var order UserOrder

		err := rows.Scan(&order.User_order_id, &order.Preferred_billing_address, &order.Preferred_credit_num, &order.Preferred_credit_cvs, &order.Order_day, &order.Order_month, &order.Order_year, &order.Total_paid,&order.Tracking_status, &order.Username)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		var wg sync.WaitGroup

		wg.Add(1)

		go queryOrderedBooks(w, order.User_order_id, &order.Books, &wg)

		wg.Wait()

		orders = append(orders, order)
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(orders)
}


func queryOrderedBooks(w http.ResponseWriter, user_order_id int, b *[]Book, parentwg *sync.WaitGroup) {
	
	defer parentwg.Done()
	rows, err := db.Query("SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM user_ordered_books LEFT JOIN books USING (isbn) WHERE user_order_id = $1", user_order_id)
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

	*b = books

}