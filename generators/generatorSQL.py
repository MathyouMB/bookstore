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
    ddl.write("insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id, hidden, expenditure) values ('"+isbn[x]+"','"+names[x]+"', '100', '2.99','25','10','"+genres[x]+"','0.05','"+str(randrange(1,10))+"', 'false','1.00');\n")

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
for x in range(0, 50):
    ddl.write("insert into book_authors (isbn, author_id) values ('"+isbn[x]+"','"+str(randrange(1,10))+"');\n")
    ddl.write("insert into book_authors (isbn, author_id) values ('"+isbn[x]+"','"+str(randrange(11,20))+"');\n")

bookISBN.close()

usernames = open("./data/usernames.txt", "r")
firstNames = open("./data/firstNames.txt", "r")
lastNames = open("./data/lastNames.txt", "r")
addresses = open("./data/addresses.txt", "r")
creditCard = open("./data/creditCardNums.txt", "r")
cvs = open("./data/cvs.txt", "r")
passwords = open("./data/passwords.txt", "r")

user = usernames.read().splitlines()
first = firstNames.read().splitlines()
last = lastNames.read().splitlines()
a = addresses.read().splitlines()
c = creditCard.read().splitlines()
cv = cvs.read().splitlines()
p = passwords.read().splitlines()

for x in range(0, 20):
    ddl.write("insert into users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) values ('"+user[x]+str(randrange(10,99))+"','"+first[x]+"','"+last[x]+"','"+a[x]+"','"+c[x]+"','"+cv[x]+"','"+first[x]+last[x]+"@email.com','"+p[x]+"','default');\n")