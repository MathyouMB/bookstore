from random import randrange

books = open("./data/books.sql", "w")

bookISBN = open("./data/bookISBN.txt", "r")
bookNames = open("./data/bookNames.txt", "r")
bookGenres = open("./data/bookGenres.txt", "r")

isbn = bookISBN.read().splitlines()
names = bookNames.read().splitlines()
genres = bookGenres.read().splitlines()

for x in range(0, len(isbn)):
    books.write("insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('"+isbn[x]+"','"+names[x]+"', '100', '2.99','25','10','"+genres[x]+"','0.05','"+str(randrange(1,10))+"');\n")

bookISBN.close()
bookNames.close()
bookGenres.close()
books.close()


authors = open("./data/authors.sql", "w")
firstNames = open("./data/firstNames.txt", "r")
lastNames = open("./data/lastNames.txt", "r")
artistNames = open("./data/artistNames.txt", "r")

first = firstNames.read().splitlines()
last = lastNames.read().splitlines()
artist = artistNames.read().splitlines()

for x in range(0, len(first)):
    authors.write("insert into authors (first_name, last_name, artist_name, publisher_id) values ('"+first[x]+"','"+last[x]+"', '"+artist[x]+"','"+str(randrange(1,10))+"');\n")

firstNames.close()
lastNames.close()
artistNames.close()
authors.close()



authors = open("./data/publishers.sql", "w")

publisherNames = open("./data/bookPublishers.txt", "r")

publishers = publisherNames.read().splitlines()

for x in range(0, 10):
    authors.write("insert into publishers (publisher_name) values ('"+publishers[x]+"');\n")

publisherNames.close()
