import React, { useState, useEffect } from 'react';

import ListItem from '../../components/list-item/listItem.component'

import './machineList.styles.css'

const MachineList = () => {
    const [machines, setMachines] = useState('')

    useEffect(() => {
        fetch('http://localhost:5000/machines')
            .then(res => res.json())
            .then(data => setMachines(data))
            .then(console.log(machines))
    }, [])

    return (
        <div className="machine-list">
            {
                // console.log(machines)
                machines ?
                    machines.map(item =>{console.log(item);return <ListItem key={item.id} item={item} />})
                    :
                    null
            }
        </div>
    )
}

export default MachineList;