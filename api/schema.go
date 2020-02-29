
package main

type Book struct {
	ISBN       	  						string        `json:"ISBN"`
	Book_title    						string   		`json:"Book_title"`
	Page_num      						int     		`json:"Page_num"`
	Book_price    						float32     	`json:"Book_price"`
	Inventory_count     				int     		`json:"Inventory_count"`
	Restock_threshold   				int     		`json:"Restock_threshold"`
	Publisher_sale_percentage    		float32     	`json:"Publisher_sale_percentage"`
	Publisher_id   						int     		`json:"Publisher_id"`
}
