create table publishers
	(
	 publisher_id		SERIAL PRIMARY KEY, 
	 publisher_name		varchar(25) NOT NULL
	);

create table books
	(
	 isbn						varchar(13),
	 book_title					varchar(50),
	 page_num					numeric(5,0),
	 book_price 				decimal(7,2),
	 inventory_count			numeric(5,0),
	 restock_threshold			numeric(5,0),
	 publisher_sale_percentage	numeric(3,2),
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
	 email_text					varchar(1000)
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

insert into publishers (publisher_name) values ('test publisher')
insert into books (isbn,book_title,page_num,book_price,publisher_id) values ('1','Book', '100', '2.99','1');


