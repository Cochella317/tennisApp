//Methods for user (SQL Queries and Helper Functions)

const db = require('../config/database');

const createUser = (email, hashedPassword, callback) => {

    const sql = `
        INSERT INTO User (email, password)
        VALUES (?, ?)
    `;

    db.query(
        sql,
        [email, hashedPassword],
        callback
    );
};

const findUserByEmail = (email, callback) => {

    const sql = `SELECT * FROM User WHERE email = ?`;

    db.query(sql, [email], callback);
};

module.exports = {
    createUser,
    findUserByEmail
};