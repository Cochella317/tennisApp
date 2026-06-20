const User = require('../models/User');

const bcrypt = require('bcryptjs');

const jwt = require('jsonwebtoken');

const loginUser = (req, res) => {

    const { email, password } = req.body;

    User.findUserByEmail(email, async (err, results) => {

        if (err) {

            return res.status(500).json({
                message: err.message
            });
        }

        // No user found
        if (results.length === 0) {
            return res.status(400).json({
                message: 'Invalid credentials, no user found'
            });
        }

        const user = results[0];

        // Compare passwords
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(400).json({
                message: 'Invalid credentials, wrong password'
            });
        }

        // Create token
        const token = jwt.sign({userId: user.id}, process.env.JWT_SECRET,{expiresIn: '7d'});

        console.log("Got to authController");

        res.json({ message: 'Login sucessful', token});
    });

};


const registerUser = (req, res) => {

}; 

module.exports = {
    registerUser,
    loginUser
    };