require('dotenv').config();

const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');

const server = express();
const PORT = 3000;

server.use(cors()); 
server.use(express.json());
server.use('/auth', authRoutes); 

server.listen(PORT, (error) =>{
    if(!error)
        console.log("Server is Successfully Running and App is listening on port "+ PORT);
    else 
        console.log("Error occurred, server can't start", error);
    }
);

server.get('/', (req, res) => {
    res.send('Hello, Express!');
});