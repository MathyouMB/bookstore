from faker import Faker
fake = Faker()

f = open("./data/bookISBN.txt", "w")

for x in range(0,50):
    f.write(fake.isbn10(separator='-')+"\n")

f.close()
