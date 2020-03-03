package main

import (
	"encoding/json"
	"net/http"
	"fmt"
//	"sync"
//	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

type LoginRequestBody struct {
	Username 	string	`json:"Username"`
	Password	string  `json:"Password"`
}

func login(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /login")
	var body LoginRequestBody

	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	rows, err := db.Query(`SELECT * FROM users WHERE username = $1`, body.Username)
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
	}
	var user User

	defer rows.Close()
	for rows.Next() {
		err := rows.Scan(&user.Username, &user.First_name, &user.Last_name, &user.Billing_address, &user.Credit_card_number, &user.Credit_card_cvs, &user.Email_address, &user.Password, &user.Role)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)

	if(user.Password == body.Password){
		json.NewEncoder(w).Encode(user)
	}else{
		json.NewEncoder(w).Encode("Login Failed")
	}
}
