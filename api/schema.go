
package main

type Publisher struct {
	Publisher_id       	  				int        `json:"Publisher_id"`
	Publisher_name    					string     `json:"Publisher_name"`
}

type Author struct {
	Author_id       	  				int        		`json:"Author_id"`
	First_name    						string     		`json:"First_name"`
	Last_name    						string     		`json:"Last_name"`
	Artist_name    						string     		`json:"Artist_name"`
	Publisher_id   						int     		`json:"Publisher_id"`
}
type Book struct {
	ISBN       	  						string        `json:"ISBN"`
	Book_title    						string   		`json:"Book_title"`
	Page_num      						int     		`json:"Page_num"`
	Book_price    						float32     	`json:"Book_price"`
	Inventory_count     				int     		`json:"Inventory_count"`
	Restock_threshold   				int     		`json:"Restock_threshold"`
	Book_genre    						string     		`json:"Book_genre"`
	Publisher_sale_percentage    		float32     	`json:"Publisher_sale_percentage"`
	Publisher_id   						int     		`json:"Publisher_id"`
	Publisher  							Publisher 		`json:"Publisher"`
	Authors  							[]Author 		`json:"Authors"`

}


type User struct {
	Username       	  					string        `json:"Username"`
	First_name    						string     		`json:"First_name"`
	Last_name    						string     		`json:"Last_name"`
	Billing_address    					string     		`json:"Billing_address"`
	Credit_card_number     				int     		`json:"Credit_card_number"`
	Credit_card_cvs   					int     		`json:"Credit_card_cvs"`
	Email_address    					string     		`json:"Email_address"`
	Password    						string     		`json:"Password"`
}
