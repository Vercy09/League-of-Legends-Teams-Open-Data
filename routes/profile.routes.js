const express = require('express');
const router = express.Router();
//const {requiresAuth} = require('express-openid-connect');

router.get('/', (req, res) => {
    if(req.oidc.isAuthenticated()) {
        res.render('profile', {
            title: 'Profile',
            user: req.oidc.user
        });
    } 
    else {
        res.sendStatus(401);
    }
})

module.exports = router;