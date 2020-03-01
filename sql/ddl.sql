create table publishers
	(
	 publisher_id		SERIAL PRIMARY KEY, 
	 publisher_name		varchar(25) NOT NULL
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
	 display_name 		varchar(25),
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

insert into publishers (publisher_name) values ('test publisher');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1','Book', '100', '2.99','25','10','genre test','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4280-9220-X','The Way Through the Woods', '100', '2.99','25','10','Fairy tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-07-340569-9','Recalled to Life', '100', '2.99','25','10','Horror','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7240-6702-7','Beneath the Bleeding', '100', '2.99','25','10','Comic/Graphic Novel','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-275-95272-0','In a Glass Darkly', '100', '2.99','25','10','Speech','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-301-82638-2','Tirra Lirra by the River', '100', '2.99','25','10','Tall tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-00-731565-1','Jacob Have I Loved', '100', '2.99','25','10','Mythology','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5488-4521-3','The Torment of Others', '100', '2.99','25','10','Historical fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-19-030130-9','Unweaving the Rainbow', '100', '2.99','25','10','Fantasy','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-83437-018-3','An Evil Cradling', '100', '2.99','25','10','Mystery','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-210-71005-5','The Torment of Others', '100', '2.99','25','10','Folklore','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-10-975457-3','Beneath the Bleeding', '100', '2.99','25','10','Fanfiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-88169-027-9','Nine Coaches Waiting', '100', '2.99','25','10','Tall tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7970-2651-7','The Mirror Crackd from Side to Side', '100', '2.99','25','10','Science fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-59729-070-X','Taming a Sea Horse', '100', '2.99','25','10','Historical fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-232-85379-8','Quo Vadis', '100', '2.99','25','10','Historical fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-8215-4495-0','Paths of Glory', '100', '2.99','25','10','Horror','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-272-66645-9','A Many-Splendoured Thing', '100', '2.99','25','10','Textbook','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-06-747899-9','An Acceptable Time', '100', '2.99','25','10','Mythopoeia','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-255-90383-9','To Say Nothing of the Dog', '100', '2.99','25','10','Fanfiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-09-721973-8','The Daffodil Sky', '100', '2.99','25','10','Suspense/Thriller','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-76719-553-2','Down to a Sunless Sea', '100', '2.99','25','10','Mystery','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-15-031562-7','The Way of All Flesh', '100', '2.99','25','10','Folklore','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-946295-14-X','A Time to Kill', '100', '2.99','25','10','Fiction narrative','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-77499-258-2','An Instant In The Wind', '100', '2.99','25','10','Horror','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-340-00569-6','Lilies of the Field', '100', '2.99','25','10','Crime/Detective','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-633-52285-6','For a Breath I Tarry', '100', '2.99','25','10','Classic','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-159-68421-9','The Way of All Flesh', '100', '2.99','25','10','Narrative nonfiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-272-71501-8','The Doors of Perception', '100', '2.99','25','10','Tall tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4743-6623-6','Eyeless in Gaza', '100', '2.99','25','10','Comic/Graphic Novel','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-352-59863-8','That Hideous Strength', '100', '2.99','25','10','Short story','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5184-7112-9','An Evil Cradling', '100', '2.99','25','10','Realistic fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-69347-110-8','Brandy of the Damned', '100', '2.99','25','10','Classic','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-365-68840-2','Things Fall Apart', '100', '2.99','25','10','Fantasy','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-963582-93-4','The Line of Beauty', '100', '2.99','25','10','Crime/Detective','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-112-45087-4','The Heart Is Deceitful Above All Things', '100', '2.99','25','10','Biography/Autobiography','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-5467-3021-4','The Millstone', '100', '2.99','25','10','Humor','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-11-473562-X','A Summer Bird-Cage', '100', '2.99','25','10','Reference book','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-215-19546-X','All the Kings Men', '100', '2.99','25','10','Western','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-879384-48-5','For a Breath I Tarry', '100', '2.99','25','10','Tall tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-08-159405-5','Many Waters', '100', '2.99','25','10','Metafiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-62090-151-X','A Summer Bird-Cage', '100', '2.99','25','10','Crime/Detective','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-86040-708-X','To Sail Beyond the Sunset', '100', '2.99','25','10','Comic/Graphic Novel','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-06-163520-1','A Time of Gifts', '100', '2.99','25','10','Fairy tale','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4206-3669-3','The Waste Land', '100', '2.99','25','10','Suspense/Thriller','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-4708-2115-X','Bloods a Rover', '100', '2.99','25','10','Biography/Autobiography','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-80395-095-1','No Country for Old Men', '100', '2.99','25','10','Fiction in verse','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-251-74983-6','An Acceptable Time', '100', '2.99','25','10','Realistic fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-7679-1737-5','The Lathe of Heaven', '100', '2.99','25','10','Science fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('1-354-15493-2','The Torment of Others', '100', '2.99','25','10','Science fiction','0.05','1');
insert into books (isbn, book_title, page_num, book_price, inventory_count, restock_threshold, book_genre, publisher_sale_percentage, publisher_id) values ('0-15-343991-2','Butter In a Lordly Dish', '100', '2.99','25','10','Fiction narrative','0.05','1');
