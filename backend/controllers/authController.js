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
                message: 'User not found'
            });
        }

        const user = results[0];

        // Compare passwords
        const isMatch = await bcrypt.compare(password, user.Password);

        if (!isMatch) {
            return res.status(400).json({
                message: 'Wrong Password'
            });
        }

        // Create token
        const token = jwt.sign({userId: user.User_ID}, process.env.JWT_SECRET,{expiresIn: '7d'});

        res.json({ message: 'Login sucessful', token});
    });

};


const registerUser = (req, res) => {
    const {firstName, lastName, email, password} = req.body; 

    const hashedPassword = bcrypt.hashSync(password, 10); 
     
    User.createUser(firstName, lastName, email, hashedPassword, async (err, result) => {
         if (err) {
            return res.status(500).json({
                message: err.message
            });
        }

        console.log("Created the user, at this stage");
        //By this point, new user has been created. Now get their user ID 
        User.findUserByEmail(email, async (err, results) => {

            if (err) {
                return res.status(500).json({
                    message: err.message
                });
            }

            // No user found
            if (results.length === 0) {
                return res.status(400).json({
                    message: 'User not found'
                });
            }

            const user = results[0];

            // Create token
            const token = jwt.sign({userId: user.User_ID}, process.env.JWT_SECRET,{expiresIn: '7d'});

            res.json({ message: 'Account Created Sucessfully', token});
    
        });  
    })

}; 

module.exports = {
    registerUser,
    loginUser
    };