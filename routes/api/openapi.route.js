const express = require('express');
const router = new express.Router();
const openapi = require('../../public/data/openapi.json');
 
let serverError = {
  code: 500,
  status: "Internal server error",
  message: "Something went wrong",
  response: null
}

router.get('/', async (req, res, next) => {
  try {
    res.status(200).send(openapi);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});

module.exports = router;