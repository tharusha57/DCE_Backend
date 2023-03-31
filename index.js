const express = require('express')
const customerRoute = require('./routes/customer')

const app = express()

app.use(express.json())

app.use('/api' , customerRoute)

app.listen(4000, () => {
    console.log('Server is listening')
})