const express = require('express')
const bodyParser = require('body-parser')
const knex = require('knex')

const app = express()
app.use(bodyParser.json())

const db = knex({
    client: 'mssql',
    connection: {
        server: 'TOSHIBA',
        user: 'abolfazl',
        password: '12345',
        database: 'sport club',
        options: {
            // "encrypt": true, 
            "enableArithAbort": true,
            // 'port': '1234'
        }
    }
});


//get view list
app.get('/machines', (req, res) => {
    db.select('*').from("machine")
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting MACHINES'))
})
app.get('/trainers', (req, res) => {
    db.select('*').from('Trainer')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting TRAINERS'))
})
app.get('/customers', (req, res) => {
    db.select('*').from('Customer')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting CUSTOMERS'))
})
app.get('/employees', (req, res) => {
    db.select('*').from('Employee')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting TRAINERS'))
})
app.get('/companies', (req, res) => {
    db.select('*').from('Company')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting COMPANY'))
})
app.get('/customer_report', (req, res) => {
    db.select('*').from('customer_report')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting CUSTOMER REPORT'))
})
app.get('/damage_report', (req, res) => {
    db.select('*').from('damage_report')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting DAMAGE REPORTS'))
})
app.get('/advices', (req, res) => {
    db.select('*').from('advice')
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting ADVICES'))
})

// get personal
app.get('/machines/:id', (req, res) => {
    const { id } = req.params

    db.select('*').from('damage_report').where('machine_id', '=', id)
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting DAMAGE REPORT'))
})

app.get('/customers/:id/reports', (req, res) => {
    const { id } = req.params
    db.select('*').from('customer_report').where('customer_id', '=', id)
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting CUSTOMER_REPORT'))
})

app.get('/customers/:id/advices', (req, res) => {
    const { id } = req.params
    console.log(id)
    db.select('*').from('Advice').where('customer_id', '=', id)
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting CUSTOMER ADVICE'))
})

app.get('/trainers/:id/advices', (req, res) => {
    const { id } = req.params
    console.log(id)
    db.select('*').from('Advice').where('trainer_id', '=', id)
        .then(data => res.json(data))
        .catch(err => res.status(400).json('error getting CUSTOMER ADVICE'))
})

// put data
app.put('/customers/:id/reports/create', (req, res) => {
    const { id } = req.params
    const { height, weight, bloodPressure, calloriesBurnedPerMonth } = req.body
    const date = new Date()
    // console.log(date)
    // console.log(req.body)
    // console.log(req.params)
    db.insert({
        customer_id: id,
        height,
        weight,
        bloodPressure,
        calloriesBurnedPerMonth,
        reportDate: date
    })
        .into('customer_report')
        .returning('*')
        .then(data => res.json(data))
        .catch(err => { res.status(400).json('error putting CUSTOMER REPORT'); console.log(err.message) })
})

app.put('/employee/:id/damage_reports/create', (req, res) => {
    const { id } = req.params
    const { machine_id, who, detail } = req.body

    const date = new Date()

    db.insert({
        employee_id: id,
        machine_id,
        who,
        detail,
        reportDate: date
    })
        .into('damage_report')
        .returning('*')
        .then(data => res.json(data))
        .catch(err => { res.status(400).json('error putting DAMAGE REPORT'); console.log(err.message) })
})

app.put('/trainer/:id/advices/create', (req, res) => {
    const { id } = req.params
    const { customer_id, training, period, routine, time, detail } = req.body

    const date = new Date()

    db.insert({
        trainer_id: id,
        customer_id,
        training,
        period,
        routine,
        time,
        detail,
        writtenDate: date
    })
        .into('advice')
        .returning('*')
        .then(data => res.json(data))
        .catch(err => { res.status(400).json('error putting TRAINER ADVICE'); console.log(err.message) })

})

// listening
app.listen(5000, () => console.log('running on port 5000..  .'))