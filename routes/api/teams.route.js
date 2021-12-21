const express = require('express');
const teams = require('../../services/teams');
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
    const result = await teams.getTeams(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});

 
router.post('/', async (req, res, next) => {
  let options = { 
  };

  options.teamPost = req.body;

  try {
    const result = await teams.addTeam(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});
 
router.get('/:teamId', async (req, res, next) => {
  let options = { 
    "teamId": req.params.teamId,
  };


  try {
    const result = await teams.getTeamById(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});
 
router.put('/:teamId', async (req, res, next) => {
  let options = { 
    "teamId": req.params.teamId,
  };

  options.team = req.body;

  try {
    const result = await teams.updateTeam(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});
 
router.delete('/:teamId', async (req, res, next) => {
  let options = { 
    "teamId": req.params.teamId,
  };


  try {
    const result = await teams.deleteTeam(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});

router.get('/:teamId/players', async (req, res, next) => {
  let options = { 
    "teamId": req.params.teamId,
  };


  try {
    const result = await teams.getPlayersForTeam(options);
    res.status(result.status || 200).send(result.data);
  }
  catch (err) {
    res.status(500).send(serverError);
  }
});

module.exports = router;