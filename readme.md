3005 Project ~ in Developent

run server go run *.go


Important order to ensure application is up to date
	docker-compose down
	docker-compose build
	docker-compose up --force-recreate
	kompose convert -f docker-compose.yaml

/books

{
	"Book_title":"Test3",
	"Page_num": 2,
	"Book_price": 3.99
}