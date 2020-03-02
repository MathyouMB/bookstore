from faker import Faker
fake = Faker()
'''
f = open("./data/bookISBN.txt", "w")

for x in range(0,50):
    f.write(fake.isbn10(separator='-')+"\n")

f.close()
'''

f2 = open("./data/creditCardNums.txt", "w")

for x in range(0,50):
    f2.write(fake.credit_card_number(card_type=None)+"\n")

f2.close()

f3 = open("./data/cvs.txt", "w")

for x in range(0,50):
    f3.write(fake.credit_card_security_code(card_type=None)+"\n")

f3.close()