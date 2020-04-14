/* 

select book info where the book isnt hidden: 

    SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false

select book info where the book isnt hidden and matches the specified genre:

    SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false AND book_genre = $1

select books currently checked out to a user baed on specified username:

    SELECT book_checkouts_id, isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books left outer join book_checkouts using (ISBN) WHERE username = $1 AND hidden = false

select book by isbn:
    
    SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE isbn = $1   

update a book to be hidden or not hidden:

    UPDATE books SET hidden = NOT hidden WHERE isbn = $1

insert a new book

    INSERT INTO books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)

select publisher information by publisher id:

    SELECT publisher_id, publisher_name FROM publishers WHERE publisher_id = $1

select the authors who wrote a given book based on isbn:

    SELECT author_id, first_name, last_name, artist_name, authors.publisher_id FROM (authors join book_authors using(author_id)) left outer join books using (isbn) WHERE isbn = $1

select books that match the search criteria that are not hidden:

    SELECT DISTINCT isbn FROM books JOIN book_authors USING(isbn) JOIN authors USING(author_id) WHERE isbn LIKE $1 OR book_title LIKE $1 OR book_genre LIKE $1 OR first_name LIKE $1 OR last_name LIKE $1 AND hidden = false`

select the aggregate summation of books sold by genre:

    SELECT book_genre, COUNT(book_genre) FROM user_ordered_books LEFT JOIN books USING (isbn) GROUP BY book_genre

select the aggregate summation of books sold by author:

    SELECT authors.first_name, authors.last_name, COUNT(authors.author_id) FROM user_ordered_books LEFT JOIN book_authors USING (isbn) JOIN authors USING (author_id) GROUP BY(authors.author_id)

select all info of book_checkouts that belong to a given user:
    
    SELECT * FROM book_checkouts WHERE username = $1

insert a new book_checkout:

    INSERT INTO book_checkouts (isbn, username) VALUES ($1, $2)

delete a book_checkout by id:

    DELETE FROM book_checkouts WHERE book_checkouts_id = $1

insert a new user_order and return the orders id on insertion:

    INSERT INTO user_orders (preferred_billing_address, preferred_credit_num, preferred_credit_cvs, order_day, order_month, order_year, total_paid, tracking_status, username) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING user_order_id

select every item checked out to a given user:

    SELECT book_checkouts_id,isbn FROM book_checkouts WHERE username = $1

insert a new user_ordered_book:

    INSERT INTO user_ordered_books (isbn, user_order_id) VALUES ($1, $2)

update inventory of book to be one less than before:

    UPDATE books SET inventory_count = inventory_count - 1 WHERE isbn = $1

update the bank account balance of a given publisher after a sale:

    UPDATE bank_accounts SET account_balance = account_balance + $1 WHERE publisher_id = $2

select how many books of a given isbn have been sold in the previous month:

    SELECT COUNT(order_month) FROM user_ordered_books LEFT JOIN user_orders USING (user_order_id) WHERE order_month = $1 AND isbn = $2

insert a new store order:

    INSERT INTO store_orders (book_quantity, email_text, isbn, publisher_id) VALUES ($1, $2, $3, $4)

select all user_orders by username:

    SELECT * FROM user_orders WHERE username = $1

select all the books belonging to a user_order:

    SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM user_ordered_books LEFT JOIN books USING (isbn) WHERE user_order_id = $1

select user information by username:

    SELECT * FROM users WHERE username = $1

insert a new user:

    INSERT INTO users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
*/