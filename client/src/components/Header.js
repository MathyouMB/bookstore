import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faBook, faSignInAlt, faUser, faShoppingCart} from '@fortawesome/free-solid-svg-icons'
import '../style/Header.scss';
import { Link } from "react-router-dom";
function Header(props) {
  const bookIcon = <FontAwesomeIcon icon={faBook} />
  const signinIcon = <FontAwesomeIcon icon={faSignInAlt} />
  const userIcon = <FontAwesomeIcon icon={faUser} />
  const shoppingCartIcon = <FontAwesomeIcon icon={faShoppingCart} />
  return (
   
    <div className="header">
        <Link to={"/books"}><div className="header-title-text">{bookIcon}</div></Link>
        {
          props.user == null ? 
              <Link to={"/login"}><div className="header-title-text-signin">{signinIcon}</div></Link>
          : 
          <div className="header-logged-in-icons">
               <Link to={"/books"}><div className="header-title-text-signin">{userIcon}</div></Link>
               <Link to={"/cart"}><div className="header-title-text-signin">{shoppingCartIcon}</div></Link>
          </div>
        }
       
    </div>
  );
}

export default Header;