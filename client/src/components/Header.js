import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faBook} from '@fortawesome/free-solid-svg-icons'
import '../style/Header.scss';
import { Link } from "react-router-dom";
function Header() {
  const bookIcon = <FontAwesomeIcon icon={faBook} />
  return (
    <div className="header">
        <Link to={"/books"}><div className="header-title-text">{bookIcon}</div></Link>
    </div>
  );
}

export default Header;