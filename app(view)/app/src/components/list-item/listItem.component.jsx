import React from 'react';

import './listItem.styles.css'

const ListItem = ({ item }) => {
    return (
        <div className='list-item'>
            {console.log(item)}
            <div>
                <h3>Name: {item.name}</h3>
                <div>Condition: {item.condition}</div>
                <p>Detail: {item.detail}</p>
                <div>Time per Person: {item.timePerPerson}</div>
                <div>Type: {item.type}</div>
            </div>
        </div>
    );
};

export default ListItem;