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
	fmt.Println(body.Username)
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

func createUser(w http.ResponseWriter, r *http.Request) {
	fmt.Println("POST /users")
	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		fmt.Println(err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	_, err := db.Exec(`INSERT INTO users (username, first_name, last_name, billing_address, credit_card_num, credit_card_cvs, email_address, password, role) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`, user.Username, user.First_name, user.Last_name, user.Billing_address, user.Credit_card_number, user.Credit_card_cvs, user.Email_address, user.Password, user.Role)
	if err != nil {
		fmt.Println(err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode("Book Succesfully Created")
}
