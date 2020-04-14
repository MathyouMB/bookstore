
import React, { useEffect, useState } from 'react';
import '../style/Login.scss';
import {Link, Redirect} from "react-router-dom";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faUser} from '@fortawesome/free-solid-svg-icons'

function UserCreationPage(props) {
  const icon = <FontAwesomeIcon icon={faUser} />

  let [username,setUsername] = useState("");
  let [firstName,setFirstName] = useState("");
  let [lastName,setLastName] = useState("");
  let [billingAddress,setBillingAddress] = useState("");
  let [creditCardNum,setCreditCardNum] = useState("");
  let [cvs,setCvs] = useState("");
  let [email,setEmail] = useState("");
  let [password,setPassword] = useState("");

  let [redirect, setRedirect] = useState(false);


  let handleInputChange = function(e){
    switch(e.target.name){
        case "username":
            setUsername(e.target.value);
            break;
        case "first":
            setFirstName(e.target.value);
            break;
        case "last":
            setLastName(e.target.value);
            break;
        case "address":
            setBillingAddress(e.target.value);
            break;
        case "credit":
            setCreditCardNum(e.target.value);
            break;
        case "cvs":
            setCvs(e.target.value);
            break;
        case "email":
            setEmail(e.target.value);
            break;
        case "password":
            setPassword(e.target.value);
            break;
        
      default:
        break;
  }
}


  const queryData = async () =>{

   const b = {
    "Username": username,
    "First_name": firstName,
    "Last_name": lastName,
    "Billing_address": billingAddress,
    "Credit_card_num": parseInt(creditCardNum),
    "Credit_card_cvs": parseInt(cvs),
    "Email_address": email,
    "Password": password,
    "Role": "default"
   }

    const settings = {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify(b)
    };
    try {
        let fetchResponse = await fetch(`http://localhost:8080/users`, settings);
        let data = await fetchResponse.json();
        console.log(data);
        setRedirect(true)
    } catch (e) {
        console.log(e)
        return e;
    }    

  }

  const renderRedirect = () => {
    if (redirect) {
      return <Redirect to = {"/login"} />
    }
  }
  
  return (
    <div className="login-page">
    {renderRedirect()}
    <div className="login-page-container">
      <div className="login-icon">
        {icon}
      </div>
      <br></br>
      <br></br>
      <div className="group">      
        <input className="login-input" name="username" type="text" value={username} placeholder="username" onChange={handleInputChange} required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="first" type="text" value={firstName} placeholder="first name" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="last" type="text" value={lastName} placeholder="last name" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="address" type="text" value={billingAddress} placeholder="billing address" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="credit" type="text" value={creditCardNum} placeholder="credit card number" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="cvs" type="text" value={cvs} placeholder="credit card cvs" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="email" type="text" value={email} placeholder="email" onChange={handleInputChange}  required></input>
      </div>

      <div className="group">      
        <input className="login-input" name="password" type="text" value={password} placeholder="password" onChange={handleInputChange}  required></input>
      </div>

      <div className="wrapper">
        <div className="login-button" onClick={()=>{queryData()}}>Create</div>
      </div>
    </div>
    </div>
  );
}

export default UserCreationPage;
