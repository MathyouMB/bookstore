import React, { useEffect, useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faShippingFast} from '@fortawesome/free-solid-svg-icons'
import { Link, Redirect } from "react-router-dom";
import CartItem from './CartItem.js';
import '../style/Order.scss';

function Order(props) {

    const icon = <FontAwesomeIcon icon={faShippingFast} />

    return (
        <div className="order">
            <div className="order-icon">{icon}</div>
            <div className="order-info">
            <table>
                <tr>
                    <td>
                        Order Number: 
                    </td>
                    <td className="right-cell">
                        {props.order.User_order_id}
                    </td>
                </tr>
                <tr>
                    <td>
                        Order Date: 
                    </td>
                    <td className="right-cell">
                        {props.order.Order_day}/{props.order.Order_month}/{props.order.Order_year}
                    </td>
                </tr>
                <tr>
                    <td>
                        Order Status: 
                    </td>
                    <td className="right-cell">
                        {props.order.Tracking_status}
                    </td>
                </tr>
                <tr>
                    <td>
                        Order Cost: 
                    </td>
                    <td className="right-cell">
                        ${props.order.Total_paid}
                    </td>
                </tr>
            </table>
           
            </div>
            <br></br>
            <br></br>
            {props.order.Books.map( item => (
                    <CartItem book={item} user={props.user}/>
            ))
            }
        </div>
    );
}

export default Order;
