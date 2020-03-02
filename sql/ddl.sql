create table publishers
	(
	 publisher_id		SERIAL PRIMARY KEY, 
	 publisher_name		varchar(40) NOT NULL
	);

create table books
	(
	 isbn						varchar(13) NOT NULL,
	 book_title					varchar(50) NOT NULL,
	 page_num					numeric(5,0) NOT NULL,
	 book_price 				decimal(7,2) NOT NULL,
	 inventory_count			numeric(5,0) NOT NULL,
	 restock_threshold			numeric(5,0) NOT NULL,
	 book_genre					varchar(30) NOT NULL,
	 publisher_sale_percentage	numeric(3,2) NOT NULL,
	 publisher_id				int NOT NULL,
	 primary key (isbn),
	 foreign key (publisher_id) references publishers (publisher_id)
	);

create table collections
	(
	 collection_id				SERIAL PRIMARY KEY, 
	 collection_title			varchar(50),
	 collection_description		varchar(1000)
	);

create table collection_books
	(isbn					varchar(13) NOT NULL,
	 collection_id			int NOT NULL,
	 primary key (isbn, collection_id),
	 foreign key (isbn) references books (isbn),
	 foreign key (collection_id) references collections (collection_id)
	);
	
/* we havent given publishers the multi contacts thing yet*/

create table bank_accounts
	(publisher_id		SERIAL PRIMARY KEY, 
	 account_balance	numeric(8,2)
	);

create table authors
	(author_id			SERIAL PRIMARY KEY, 
	 first_name			varchar(25) NOT NULL,
	 last_name			varchar(25) NOT NULL,
	 artist_name 		varchar(25),
	 publisher_id		int NOT NULL,
	 foreign key (publisher_id) references publishers (publisher_id)
	);
/*needs foreign key to publisher */

create table book_authors
	(
	 isbn				varchar(13) NOT NULL,
	 author_id				int NOT NULL,
	 primary key (isbn, author_id),
	 foreign key (isbn) references books (isbn),
	 foreign key (author_id) references authors (author_id)
	);

create table store_orders
	(
	 store_order_id				SERIAL PRIMARY KEY, 
	 book_quantity				numeric(5,0),
	 email_text					varchar(1000),
	 isbn					varchar(13) NOT NULL,
	 publisher_id				int NOT NULL, 
	 foreign key (isbn) references books (isbn),
	 foreign key (publisher_id) references publishers (publisher_id)
	);


create table users
	(
	 username				varchar(10) NOT NULL,
	 first_name				varchar(25) NOT NULL,
	 last_name				varchar(25) NOT NULL,
	 billing_address		varchar(25) NOT NULL,
	 credit_card_num				numeric(19,0),
	 credit_card_cvs				numeric(3,0),
	 email_address			varchar(25) NOT NULL,
	 password				varchar(25) NOT NULL,
	 role					varchar(25) NOT NULL,
	 primary key (username)
	);

create table book_checkouts
	(
	 book_checkouts_id		SERIAL PRIMARY KEY, 
	 isbn					varchar(13) NOT NULL,
	 username				varchar(10) NOT NULL,
	 foreign key (isbn) references books (isbn),
	 foreign key (username) references users (username)
	);

create table user_orders
	(
	 user_order_id					SERIAL PRIMARY KEY, 
	 preferred_billing_address		varchar(25) NOT NULL,
	 preferred_credit_num			numeric(19,0),
	 preferred_credit_cvs			numeric(3,0),
	 order_day						numeric(2,0),
	 order_month					numeric(2,0),
	 order_year						numeric(4,0)
	);

create table checkout_orders
	(
	 book_checkouts_id				int NOT NULL,
	 user_order_id					int NOT NULL,
	 primary key (book_checkouts_id, user_order_id),
	 foreign key (book_checkouts_id) references book_checkouts (book_checkouts_id),
	 foreign key (user_order_id) references user_orders (user_order_id)
	);

/* Create Publishers because Books reference Publishers */
insert into publishers (publisher_name) values ('Book Works');
insert into publishers (publisher_name) values ('Butterworth-Heinemann');
insert into publishers (publisher_name) values ('McGraw Hill Financial');
insert into publishers (publisher_name) values ('HarperCollins');
insert into publishers (publisher_name) values ('Brill Publishers');
insert into publishers (publisher_name) values ('Flame Tree Publishing');
insert into publishers (publisher_name) values ('Book Works');
insert into publishers (publisher_name) values ('Elloras Cave');
insert into publishers (publisher_name) values ('D. Appleton & Company');
insert into publishers (publisher_name) values ('Manchester University Press');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4280-9220-X','Wildfire at Midnight', '100', '2.99','25','10','Mythology','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-07-340569-9','The Torment of Others', '100', '2.99','25','10','Tall tale','0.05','9');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7240-6702-7','Terrible Swift Sword', '100', '2.99','25','10','Humor','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-275-95272-0','Behold the Man', '100', '2.99','25','10','Fiction narrative','0.05','2');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-301-82638-2','In a Dry Season', '100', '2.99','25','10','Mystery','0.05','9');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-00-731565-1','Tender Is the Night', '100', '2.99','25','10','Historical fiction','0.05','9');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5488-4521-3','Blue Remembered Earth', '100', '2.99','25','10','Fiction narrative','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-19-030130-9','The Line of Beauty', '100', '2.99','25','10','Suspense/Thriller','0.05','8');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-83437-018-3','Recalled to Life', '100', '2.99','25','10','Fantasy','0.05','2');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-210-71005-5','Nine Coaches Waiting', '100', '2.99','25','10','Crime/Detective','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-10-975457-3','The Green Bay Tree', '100', '2.99','25','10','Western','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-88169-027-9','Recalled to Life', '100', '2.99','25','10','Mythology','0.05','7');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7970-2651-7','Little Hands Clapping', '100', '2.99','25','10','Speech','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-59729-070-X','The Cricket on the Hearth', '100', '2.99','25','10','Humor','0.05','2');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-232-85379-8','Antic Hay', '100', '2.99','25','10','Science fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-8215-4495-0','The Lathe of Heaven', '100', '2.99','25','10','Textbook','0.05','7');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-272-66645-9','Jacob Have I Loved', '100', '2.99','25','10','Mythology','0.05','9');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-06-747899-9','For a Breath I Tarry', '100', '2.99','25','10','Short story','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-255-90383-9','The Mermaids Singing', '100', '2.99','25','10','Horror','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-09-721973-8','Carrion Comfort', '100', '2.99','25','10','Legend','0.05','9');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-76719-553-2','A Catskill Eagle', '100', '2.99','25','10','Legend','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-15-031562-7','Number the Stars', '100', '2.99','25','10','Humor','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-946295-14-X','Blue Remembered Earth', '100', '2.99','25','10','Fantasy','0.05','3');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-77499-258-2','Whats Become of Waring', '100', '2.99','25','10','Narrative nonfiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-340-00569-6','The Heart Is Deceitful Above All Things', '100', '2.99','25','10','Classic','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-633-52285-6','The Yellow Meads of Asphodel', '100', '2.99','25','10','Mythopoeia','0.05','7');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-159-68421-9','Oh! To be in England', '100', '2.99','25','10','Classic','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-272-71501-8','If I Forget Thee Jerusalem', '100', '2.99','25','10','Fiction narrative','0.05','8');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4743-6623-6','The Soldiers Art', '100', '2.99','25','10','Realistic fiction','0.05','8');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-352-59863-8','Taming a Sea Horse', '100', '2.99','25','10','Short story','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5184-7112-9','Such, Such Were the Joys', '100', '2.99','25','10','Comic/Graphic Novel','0.05','8');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-69347-110-8','Antic Hay', '100', '2.99','25','10','Reference book','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-365-68840-2','Absalom, Absalom!', '100', '2.99','25','10','Realistic fiction','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-963582-93-4','Far From the Madding Crowd', '100', '2.99','25','10','Classic','0.05','3');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-112-45087-4','I Know Why the Caged Bird Sings', '100', '2.99','25','10','Legend','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5467-3021-4','A Catskill Eagle', '100', '2.99','25','10','Speech','0.05','2');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-11-473562-X','This Side of Paradise', '100', '2.99','25','10','Tall tale','0.05','8');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-215-19546-X','In Death Ground', '100', '2.99','25','10','Fairy tale','0.05','3');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-879384-48-5','The Doors of Perception', '100', '2.99','25','10','Fantasy','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-08-159405-5','To Say Nothing of the Dog', '100', '2.99','25','10','Humor','0.05','4');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-62090-151-X','I Sing the Body Electric', '100', '2.99','25','10','Legend','0.05','7');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-86040-708-X','Mr Standfast', '100', '2.99','25','10','Suspense/Thriller','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-06-163520-1','Clouds of Witness', '100', '2.99','25','10','Folklore','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4206-3669-3','The Heart Is Deceitful Above All Things', '100', '2.99','25','10','Comic/Graphic Novel','0.05','3');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4708-2115-X','The Golden Bowl', '100', '2.99','25','10','Fanfiction','0.05','7');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-80395-095-1','Look Homeward, Angel', '100', '2.99','25','10','Classic','0.05','6');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-251-74983-6','Recalled to Life', '100', '2.99','25','10','Humor','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7679-1737-5','To Your Scattered Bodies Go', '100', '2.99','25','10','Realistic fiction','0.05','4');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-354-15493-2','For Whom the Bell Tolls', '100', '2.99','25','10','Fiction narrative','0.05','5');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-15-343991-2','The Proper Study', '100', '2.99','25','10','Short story','0.05','6');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Floyd','Stracke', 'Monet','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Patsy','Koss', 'Degas','4');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Reyes','Feil', 'Klimt','2');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Rebbecca','Steuber', 'Raphael','9');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Flavia','Grady', 'Gauguin','8');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Sallie','Fay', 'Klimt','5');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Hallie','Rodriguez', 'Paul Klee','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Junita','Schmeler', 'Pollock','4');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Penni','Satterfield', 'Pissarro','9');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Paris','Shields', 'Gauguin','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Cornell','Walsh', 'Klimt','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Jasmin','Jaskolski', 'Cassatt','9');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Dillon','Bayer', 'Ansel Adams','6');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Lindsay','Herzog', 'Vettriano','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Olen','Bogan', 'Paul Klee','3');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Benton','Spinka', 'Winslow Homer','5');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Mikaela','Botsford', 'Raphael','7');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Kerstin','Predovic', 'Rembrandt','2');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Carl','Denesik', 'Pollock','8');
insert into authors (first_name, last_name, artist_name, publisher_id) values ('Collen','Hahn', 'Vettriano','7');
insert into book_authors (isbn, author_id) values ('1-4280-9220-X','5');
insert into book_authors (isbn, author_id) values ('1-4280-9220-X','17');
insert into book_authors (isbn, author_id) values ('1-07-340569-9','4');
insert into book_authors (isbn, author_id) values ('1-07-340569-9','17');
insert into book_authors (isbn, author_id) values ('0-7240-6702-7','8');
insert into book_authors (isbn, author_id) values ('0-7240-6702-7','14');
insert into book_authors (isbn, author_id) values ('1-275-95272-0','6');
insert into book_authors (isbn, author_id) values ('1-275-95272-0','16');
insert into book_authors (isbn, author_id) values ('0-301-82638-2','3');
insert into book_authors (isbn, author_id) values ('0-301-82638-2','17');
insert into book_authors (isbn, author_id) values ('0-00-731565-1','5');
insert into book_authors (isbn, author_id) values ('0-00-731565-1','19');
insert into book_authors (isbn, author_id) values ('1-5488-4521-3','5');
insert into book_authors (isbn, author_id) values ('1-5488-4521-3','15');
insert into book_authors (isbn, author_id) values ('0-19-030130-9','6');
insert into book_authors (isbn, author_id) values ('0-19-030130-9','12');
insert into book_authors (isbn, author_id) values ('1-83437-018-3','7');
insert into book_authors (isbn, author_id) values ('1-83437-018-3','18');
insert into book_authors (isbn, author_id) values ('0-210-71005-5','2');
insert into book_authors (isbn, author_id) values ('0-210-71005-5','14');
insert into book_authors (isbn, author_id) values ('0-10-975457-3','3');
insert into book_authors (isbn, author_id) values ('0-10-975457-3','14');
insert into book_authors (isbn, author_id) values ('0-88169-027-9','5');
insert into book_authors (isbn, author_id) values ('0-88169-027-9','15');
insert into book_authors (isbn, author_id) values ('0-7970-2651-7','3');
insert into book_authors (isbn, author_id) values ('0-7970-2651-7','15');
insert into book_authors (isbn, author_id) values ('1-59729-070-X','7');
insert into book_authors (isbn, author_id) values ('1-59729-070-X','14');
insert into book_authors (isbn, author_id) values ('1-232-85379-8','8');
insert into book_authors (isbn, author_id) values ('1-232-85379-8','15');
insert into book_authors (isbn, author_id) values ('0-8215-4495-0','6');
insert into book_authors (isbn, author_id) values ('0-8215-4495-0','12');
insert into book_authors (isbn, author_id) values ('0-272-66645-9','9');
insert into book_authors (isbn, author_id) values ('0-272-66645-9','18');
insert into book_authors (isbn, author_id) values ('0-06-747899-9','1');
insert into book_authors (isbn, author_id) values ('0-06-747899-9','13');
insert into book_authors (isbn, author_id) values ('0-255-90383-9','8');
insert into book_authors (isbn, author_id) values ('0-255-90383-9','17');
insert into book_authors (isbn, author_id) values ('0-09-721973-8','4');
insert into book_authors (isbn, author_id) values ('0-09-721973-8','17');
insert into book_authors (isbn, author_id) values ('1-76719-553-2','2');
insert into book_authors (isbn, author_id) values ('1-76719-553-2','15');
insert into book_authors (isbn, author_id) values ('0-15-031562-7','5');
insert into book_authors (isbn, author_id) values ('0-15-031562-7','12');
insert into book_authors (isbn, author_id) values ('0-946295-14-X','7');
insert into book_authors (isbn, author_id) values ('0-946295-14-X','18');
insert into book_authors (isbn, author_id) values ('1-77499-258-2','6');
insert into book_authors (isbn, author_id) values ('1-77499-258-2','11');
insert into book_authors (isbn, author_id) values ('0-340-00569-6','7');
insert into book_authors (isbn, author_id) values ('0-340-00569-6','17');
insert into book_authors (isbn, author_id) values ('0-633-52285-6','6');
insert into book_authors (isbn, author_id) values ('0-633-52285-6','12');
insert into book_authors (isbn, author_id) values ('1-159-68421-9','2');
insert into book_authors (isbn, author_id) values ('1-159-68421-9','17');
insert into book_authors (isbn, author_id) values ('0-272-71501-8','4');
insert into book_authors (isbn, author_id) values ('0-272-71501-8','17');
insert into book_authors (isbn, author_id) values ('1-4743-6623-6','7');
insert into book_authors (isbn, author_id) values ('1-4743-6623-6','16');
insert into book_authors (isbn, author_id) values ('0-352-59863-8','6');
insert into book_authors (isbn, author_id) values ('0-352-59863-8','11');
insert into book_authors (isbn, author_id) values ('1-5184-7112-9','8');
insert into book_authors (isbn, author_id) values ('1-5184-7112-9','13');
insert into book_authors (isbn, author_id) values ('1-69347-110-8','7');
insert into book_authors (isbn, author_id) values ('1-69347-110-8','19');
insert into book_authors (isbn, author_id) values ('1-365-68840-2','9');
insert into book_authors (isbn, author_id) values ('1-365-68840-2','14');
insert into book_authors (isbn, author_id) values ('1-963582-93-4','8');
insert into book_authors (isbn, author_id) values ('1-963582-93-4','13');
insert into book_authors (isbn, author_id) values ('1-112-45087-4','8');
insert into book_authors (isbn, author_id) values ('1-112-45087-4','12');
insert into book_authors (isbn, author_id) values ('1-5467-3021-4','4');
insert into book_authors (isbn, author_id) values ('1-5467-3021-4','19');
insert into book_authors (isbn, author_id) values ('0-11-473562-X','7');
insert into book_authors (isbn, author_id) values ('0-11-473562-X','18');
insert into book_authors (isbn, author_id) values ('1-215-19546-X','8');
insert into book_authors (isbn, author_id) values ('1-215-19546-X','11');
insert into book_authors (isbn, author_id) values ('1-879384-48-5','2');
insert into book_authors (isbn, author_id) values ('1-879384-48-5','18');
insert into book_authors (isbn, author_id) values ('1-08-159405-5','1');
insert into book_authors (isbn, author_id) values ('1-08-159405-5','12');
insert into book_authors (isbn, author_id) values ('1-62090-151-X','7');
insert into book_authors (isbn, author_id) values ('1-62090-151-X','13');
insert into book_authors (isbn, author_id) values ('0-86040-708-X','1');
insert into book_authors (isbn, author_id) values ('0-86040-708-X','15');
insert into book_authors (isbn, author_id) values ('1-06-163520-1','2');
insert into book_authors (isbn, author_id) values ('1-06-163520-1','13');
insert into book_authors (isbn, author_id) values ('1-4206-3669-3','7');
insert into book_authors (isbn, author_id) values ('1-4206-3669-3','11');
insert into book_authors (isbn, author_id) values ('1-4708-2115-X','8');
insert into book_authors (isbn, author_id) values ('1-4708-2115-X','12');
insert into book_authors (isbn, author_id) values ('1-80395-095-1','5');
insert into book_authors (isbn, author_id) values ('1-80395-095-1','17');
insert into book_authors (isbn, author_id) values ('1-251-74983-6','7');
insert into book_authors (isbn, author_id) values ('1-251-74983-6','11');
insert into book_authors (isbn, author_id) values ('0-7679-1737-5','1');
insert into book_authors (isbn, author_id) values ('0-7679-1737-5','11');
insert into book_authors (isbn, author_id) values ('1-354-15493-2','8');
insert into book_authors (isbn, author_id) values ('1-354-15493-2','18');
insert into book_authors (isbn, author_id) values ('0-15-343991-2','7');
insert into book_authors (isbn, author_id) values ('0-15-343991-2','14');
