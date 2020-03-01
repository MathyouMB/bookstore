import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faBook} from '@fortawesome/free-solid-svg-icons'
import '../style/Header.scss';
function Header() {
  const bookIcon = <FontAwesomeIcon icon={faBook} />
  return (
    <div className="header">
        <div className="header-title-text">{bookIcon}</div>

    </div>
  );
}

export default Header;