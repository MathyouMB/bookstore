/* 

get book info where the book isnt hidden 

    SELECT isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id FROM books WHERE hidden = false
*/