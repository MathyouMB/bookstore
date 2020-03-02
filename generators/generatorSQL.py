from random import randrange

ddl = open("./data/ddl.sql", "w")


publisherNames = open("./data/bookPublishers.txt", "r")

publishers = publisherNames.read().splitlines()

for x in range(0, 10):
    ddl.write("insert into publishers (publisher_name) values ('"+publishers[x]+"');\n")

publisherNames.close()



bookISBN = open("./data/bookISBN.txt", "r")
bookNames = open("./data/bookNames.txt", "r")
bookGenres = open("./data/bookGenres.txt", "r")

isbn = bookISBN.read().splitlines()
names = bookNames.read().splitlines()
genres = bookGenres.read().splitlines()

for x in range(0, len(isbn)):
    ddl.write("insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('"+isbn[x]+"','"+names[x]+"', '100', '2.99','25','10','"+genres[x]+"','0.05','"+str(randrange(1,10))+"');\n")

bookISBN.close()
bookNames.close()
bookGenres.close()


firstNames = open("./data/firstNames.txt", "r")
lastNames = open("./data/lastNames.txt", "r")
artistNames = open("./data/artistNames.txt", "r")

first = firstNames.read().splitlines()
last = lastNames.read().splitlines()
artist = artistNames.read().splitlines()

for x in range(0, len(first)):
    ddl.write("insert into authors (first_name, last_name, artist_name, publisher_id) values ('"+first[x]+"','"+last[x]+"', '"+artist[x]+"','"+str(randrange(1,10))+"');\n")

firstNames.close()
lastNames.close()
artistNames.close()


bookISBN = open("./data/bookISBN.txt", "r")
isbn = bookISBN.read().splitlines()
for x in range(0, 30):
    ddl.write("insert into book_authors (isbn, author_id) values ('"+isbn[x]+"','"+str(randrange(1,10))+"');\n")
    ddl.write("insert into book_authors (isbn, author_id) values ('"+isbn[x]+"','"+str(randrange(11,20))+"');\n")

