const express = require('express');
const router = express.Router();
//const db = require('../db/index');




router.get('/', async function (req, res, next) {
    res.render('index', {
        title: 'Home',
    });
});



module.exports = router;