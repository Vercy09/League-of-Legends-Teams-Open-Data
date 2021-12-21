const express = require('express');
const players = require('../../services/players');
const router = new express.Router();
 
let serverError = {
  code: 500,
  status: "Internal server error",
  message: "Something went wrong",
  response: null
}


router.get('/', async (req, res, next) => {
  let options = { 
  };


  try {
    const result = await players.getPlayers(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});
 
router.get('/:playerId', async (req, res, next) => {
  let options = { 
    "playerId": req.params.playerId,
  };


  try {
    const result = await players.getPlayerById(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});

module.exports = router;