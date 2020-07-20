
import React from 'react';
// import logo from './logo.svg';

import { Route, Switch } from 'react-router-dom'

import MachineList from './pages/machine-list/machineList.component'
import HomePage from './pages/home-page/homePage.component'

import './App.css';

function App() {
  return (
    <div className="App">
      {/* <Header /> */}

      <Switch>
        <Route exact path='/' component={HomePage} />
        <Route exact path='/machines' component={MachineList} />
      </Switch>
    </div>
  );
}

export default App;
