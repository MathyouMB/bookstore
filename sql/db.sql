create table books
	(book_id			SERIAL PRIMARY KEY, 
	 book_title			varchar(50),
	 page_num			numeric(5,0),
	 book_price 		decimal(7,2)
	)

insert into books values ('1','Book', '100', '2.99');
/*

Book needs
author(s), 
genre, 
publisher, 

number of pages, price

/*

create table user
	(ID		varchar(8), 
	 primary key (ID),
	);


create table collection
	(collection_id				varchar(8), 
	 collection_name			varchar(50),
	 collection_description		varchar(50),
	 primary key (collection_id),
	);

create table collection_book
	(collection_id		varchar(8), 
	 book_id			varchar(8)
	 primary key (collection_id, book_id),
	);