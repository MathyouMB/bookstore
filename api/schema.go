
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
	Hidden   							bool     		`json:"Hidden"`
	Expenditure   						float32     	`json:"Expenditure"`
	Publisher  							Publisher 		`json:"Publisher"`
	Authors  							[]Author 		`json:"Authors"`
}

type User struct {
	Username       	  					string          `json:"Username"`
	First_name    						string     		`json:"First_name"`
	Last_name    						string     		`json:"Last_name"`
	Billing_address    					string     		`json:"Billing_address"`
	Credit_card_number     				int     		`json:"Credit_card_number"`
	Credit_card_cvs   					int     		`json:"Credit_card_cvs"`
	Email_address    					string     		`json:"Email_address"`
	Password    						string     		`json:"Password"`
	Role    							string     		`json:"Role"`
}

type BookCheckout struct {
	Book_checkouts_id       	  		int        		`json:"Book_checkouts_id"`
	ISBN								string  		`json:"ISBN"`
	Username 							string			`json:"Username"`
}

type UserOrder struct {
	User_order_id       	  			int        		`json:"User_order_id"`
	Preferred_billing_address			string  		`json:"Preferred_billing_address"`
	Preferred_credit_num       	  		int        		`json:"Preferred_credit_num"`
	Preferred_credit_cvs       	  		int        		`json:"Preferred_credit_cvs"`
	Order_day       	  				int        		`json:"Order_day"`
	Order_month       	  				int        		`json:"Order_month"`
	Order_year       	  				int        		`json:"Order_year"`
	Total_paid       	  				float32        	`json:"Total_paid"`
	Tracking_status 					string			`json:"Tracking_status"`
	Username 							string			`json:"Username"`
	Books  								[]Book 			`json:"Books"`
}
