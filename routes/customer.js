const express = require('express')
const router  = express.Router()

const {getCustomers , createCustomer , updateCustomer , deleteCustomer , activeOrder} = require('../controllers/customer')

router.get('/customers' , getCustomers)

router.post('/createcustomer' , createCustomer)

router.patch('/updatecustomer/:id' , updateCustomer)

router.delete('/deletecustomer/:id' , deleteCustomer)

router.get('/activeorder/:id' , activeOrder)

module.exports = router