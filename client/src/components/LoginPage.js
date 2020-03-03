
import React, { useEffect, useState } from 'react';
import '../style/Login.scss';
import {Link, Redirect} from "react-router-dom";

function LoginPage(props) {
  
  //reading text box
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
        "Username":"cecila84",
        "Password":"WbWvAw5PiV51gXrJbCm0"
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
    } catch (e) {
        return e;
    }    
/*
    if(Username.length>0 && password.length>0){
      let data = await client
        .query({
          query: LOGIN,
          variables: {
            "Username": Username,
            "password": password
          }
        });
      console.log(data.data.login);
      props.setProfile(data.data.login)
    }else{
      console.log("invalid info...")
    }
*/
  }

  const renderRedirect = () => {
    if (redirect) {
      return <Redirect to = {"/profile?ID="+props.profile.id} />
    }
  }
  
  return (
    <div className="login-page">
    {renderRedirect()}
    <div className="login-page-container">
      <div className="wrapper">
        {/*logo here*/}
      </div>
      <br></br>
      <br></br>
      <div className="group">      
        <input type="text" value={Username} onChange={updateUsername} required></input>
        <span className="highlight"></span>
        <span className="bar"></span>
        <label>Username</label>
      </div>

      <div className="group">      
        <input type="password" value={password} onChange={updatePassword}  required></input>
        <span className="highlight"></span>
        <span className="bar"></span>
        <label>Password</label>
      </div>

      <div className="wrapper">
        <a className="fancy-button bg-gradient1" onClick={queryData}><span>Login</span></a>
      </div>
    </div>
    </div>
  );
}

export default LoginPage;
