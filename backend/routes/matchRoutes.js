const express = require('express');

const router = express.Router();

const {
    addMatch,
    findMatches,
} = require('../controllers/matchController');

//goes through middleware to authenticate user first, then complete other actions
const authenticateToken = require('../middleware/authMiddleware'); 

router.post('/addMatch',authenticateToken, addMatch);
router.get('/findMatches',authenticateToken ,findMatches);

module.exports = router;