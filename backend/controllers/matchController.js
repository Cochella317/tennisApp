const Match = require('../models/Match');

//add match 
const addMatch =  (req, res) => { 
    const {opponentFirstName, opponentLastName, date, 
    matchType, score, win, surface, firstServePercentage, 
    unforcedErrors, winners, aces, rating, whatWentWell, 
    whatToImprove, notes} = req.body; 

    const userId = req.user.userId; //get user id from jwt payload 

    Match.createMatch(opponentFirstName, opponentLastName, date, 
    matchType, score, win, surface, firstServePercentage, 
    unforcedErrors, winners, aces, userId, rating, whatWentWell, 
    whatToImprove, notes, async (err, result) => {
        if (err) {
            return res.status(500).json({
                message: err.message
            });
        }

        res.status(201).json({
            message: "Match Log Created Successfully"
        }); 

    }); 

}; 

const findMatches =  (req, res) => { 
    
}; 

module.exports = {
    addMatch,
    findMatches
    };