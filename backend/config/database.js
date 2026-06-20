const mysql = require('mysql2');

const db = mysql.createConnection({

    host: 'localhost',

    user: 'root',

    password: process.env.DB_PASSWORD,

    database: 'tennis_app'
});

db.connect((err) => {

    if (err) {
        console.log('Database connection failed');
        console.error(err);
        return;
    }

    console.log('Connected to MySQL');
});

module.exports = db;