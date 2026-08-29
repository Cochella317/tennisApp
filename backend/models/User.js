//Methods for user (SQL Queries and Helper Functions)

const db = require('../config/database');

//create user in db
const createUser = (firstName, lastName, email, hashedPassword, callback) => {

    const sql = `
        INSERT INTO User (firstName, lastName, Email, Password)
        VALUES (?, ?, ?, ?)
    `;

    db.query(
        sql,
        [firstName, lastName, email, hashedPassword],
        callback
    );
};

//find user by email in db
const findUserByEmail = (email, callback) => {

    const sql = `SELECT * FROM User WHERE Email = ?`;

    db.query(sql, [email], callback);
};

module.exports = {
    createUser,
    findUserByEmail
};