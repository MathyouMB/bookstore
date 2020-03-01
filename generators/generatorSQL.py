bookISBN = open("./data/bookISBN.txt", "r")
bookNames = open("./data/bookNames.txt", "r")
bookGenres = open("./data/bookGenres.txt", "r")
#bookGenres = open("./data/bookGenres.txt", "r")


sql = open("./data/sqlG.sql", "w")

isbn = bookISBN.read().splitlines()
names = bookNames.read().splitlines()
genres = bookGenres.read().splitlines()

for x in range(0, len(isbn)):
    sql.write("insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('"+isbn[x]+"','"+names[x]+"', '100', '2.99','25','10','"+genres[x]+"','0.05','1');\n")

bookISBN.close()
bookNames.close()
bookGenres.close()