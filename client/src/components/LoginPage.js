
import React, { useEffect, useState } from 'react';
import '../style/Login.scss';
import {Link, Redirect} from "react-router-dom";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {faUser} from '@fortawesome/free-solid-svg-icons'

function LoginPage(props) {
  const icon = <FontAwesomeIcon icon={faUser} />

  let [Username,setUsername] = useState("");
  let [password, setPassword] = useState("");
  let [redirect, setRedirect] = useState(false);

  const updateUsername = (event) => {
    setUsername(event.target.value);
    console.log("Username: "+Username);
  }
  const updatePassword = (event) => {
    setPassword(event.target.value);
    console.log("password: "+password);
  }

  useEffect(() => {
    if(props.user != null){
      setRedirect(true);
    }
  })

  const queryData = async () =>{

   const b = {
    "Username": Username,
    "Password": password
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
        let fetchResponse = await fetch(`http://localhost:8080/login`, settings);
        let data = await fetchResponse.json();
        console.log(data);
        props.setUser(data);
    } catch (e) {
        return e;
    }    

  }

  const renderRedirect = () => {
    if (redirect) {
      return <Redirect to = {"/books"} />
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
        <input className="login-input" type="text" value={Username} placeholder="Username" onChange={updateUsername} required></input>
      </div>

      <div className="group">      
        <input className="login-input" type="password" value={password} placeholder="Password" onChange={updatePassword}  required></input>
      </div>

      <div className="wrapper">
        <div className="login-button" onClick={()=>{queryData()}}>Login</div>
        <div className="signup-wrap"> <Link to="/signup"><input type="button" className="signup-button" value="Signup"></input></Link></div>
      </div>
     
    </div>
    </div>
  );
}

export default LoginPage;
