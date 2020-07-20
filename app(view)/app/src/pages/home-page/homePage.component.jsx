import React from 'react';

import { Link } from 'react-router-dom'

const HomePage = () => {


    return (
        <div className="home-page">
            <ul>
                <li>
                    <Link to='/machines'>
                        Machines List
                    </Link>
                </li>
                <li>
                    <Link to='/Trainers'>
                        Trainers List
                    </Link>
                </li>
                <li>
                    <Link to='/customers'>
                        customers List
                    </Link>
                </li>
                <li>
                    <Link to='/employees'>
                        employees List
                    </Link>
                </li>
                <li>
                    <Link to='/companies'>
                        companies List
                    </Link>
                </li>
                <li>
                    <Link to='/customer_report'>
                        customer_report List
                    </Link>
                </li>
                <li>
                    <Link to='/damage_report'>
                        damage_report List
                    </Link>
                </li>
                <li>
                    <Link to='/advices'>
                        advices List
                    </Link>
                </li>
                <li>
                    <Link to='/machines/:id'>
                        machines/ personal
                    </Link>
                </li>
                <li>
                    <Link to='/Trainers'>
                        Trainers List
                    </Link>
                </li>
                <li>
                    <Link to='/Trainers'>
                        Trainers List
                    </Link>
                </li>
                <li>
                    <Link to='/Trainers'>
                        Trainers List
                    </Link>
                </li>
                <li>
                    <Link to='/Trainers'>
                        Trainers List
                    </Link>
                </li>
            </ul>
        </div>
    );
};

export default HomePage;