const db = require('../config/database')

const getCustomers = (req,res) => {
    const query = 'SELECT * FROM customer'

    db.query(query , (err,data) => {
        if(err){
            return res.json(err)
        }
        return res.status(200).json(data)
    })
}

const createCustomer = (req,res) => {
    const query = 'INSERT INTO customer(`username` , `email` , `firstname` , `lastname` , `createdon` , `isActive`)  VALUES(?)'

    const isActive = req.body.isActive ? 1 : 0
    const createdOn = new Date().toISOString().slice(0, 19).replace('T', ' ');

    const values = [
        req.body.username,
        req.body.email,
        req.body.firstname,
        req.body.lastname,
        createdOn,
        isActive,
    ]
    
    db.query(query , [values] , (err,data) => {
        if(err){
            return res.status(500).json(err)
        }
        return res.json('Customer has been created')
    })
}

const updateCustomer = (req,res) => {
    const userId = req.params.id

    const query = "UPDATE customer SET `username`=? , `email`=? , `firstname`=? , `lastname`=? , `isActive`=? WHERE `userid` = ?"

    const values = [
        req.body.username,
        req.body.email,
        req.body.firstname,
        req.body.lastname,
        req.body.isActive
    ]

    db.query(query , [...values , userId] , (err,date) => {
        if(err){
            return res.status(500).json(err)
        }
        return res.json('Customer has been updated')
    })
}

const deleteCustomer = (req,res) => {
    const userId = req.params.id

    const query = 'DELETE FROM customer WHERE `userid`=?'

    db.query(query , [userId] , (err,data) => {
        if(err){
            return res.status(500).json(err)
        }
        return res.status(200).json('Customer has been deleted')
    })
}

const activeOrder = (req,res) => {
    const userId = req.params.id

    //Using the stored Procedure here

    const query = `CALL active_orders(?)`

    db.query(query , [userId], (err,data) => {
        if(err){
            return res.status(500).json(err)
        }
        return res.status(200).json(data)
    })
}

module.exports = {getCustomers , createCustomer , updateCustomer , deleteCustomer , activeOrder}