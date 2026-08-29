//Methods for match (SQL Queries and Helper Functions)

const db = require('../config/database');

//adds match to db                 
const createMatch = (opponentFirstName, opponentLastName, date, 
    matchType, score, win, surface, firstServePercentage, 
    unforcedErrors, winners, aces, userId, rating, whatWentWell, 
    whatToImprove, notes, callback) => {
        const sql = `INSERT INTO tennis_match (opponentFirstName, opponentLastName, Date, 
        matchType, Score, Win, Surface, firstServePercentage, unforcedErrors, 
        Winners, Aces, User_ID, Rating, whatWentWell, whatToImprove, notes)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `; 

        db.query(
            sql, 
            [opponentFirstName, opponentLastName, date, 
            matchType, score, win, surface, firstServePercentage, 
            unforcedErrors, winners, aces, userId, rating, whatWentWell, 
            whatToImprove, notes], 
            callback
        ); 
        

    };

    module.exports = {
    createMatch
};
