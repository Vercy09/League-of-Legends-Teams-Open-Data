const db = require('../db/index');

module.exports = {
  /**
  * Returns array of player objects for all players


  */
  
  getPlayers: async (options) => {

    // Implement your business logic here...
    //
    // Return all 2xx and 4xx as follows:
    //
    // return {
    //   status: 'statusCode',
    //   data: 'response'
    // }

    // If an error happens during your business logic implementation,
    // you can throw it as follows:
    //
    // throw new Error('<Error message>'); // this will result in a 500

    var data = {
        "code": "<int64>",
        "status": "<string>",
        "message": "<string>",
        "response": "<object>",
        "links": "<array>"
      },
      status = '200';
  
    const playerContext = {
        "name": "https://schema.org/givenName",
        "surname": "https://schema.org/familyName",
        "contract_ends": "https://schema.org/Date"
    }

    let players = await dbGetPlayers();


    if (players.length == 0 || players == undefined) throw new Error('Internal server error');

    players.forEach(player => {
      player['@context'] = playerContext;
    });

    data.code = 200;
    data.status = 'OK';
    data.message = 'Fetched all players';
    data.response = players;
    data.links = [];
    data.links.push(linkFactory("/{playerId}", "player", "GET"));
    return {
      status: status,
      data: data
    };
  },

  /**
  * Returns a single player object with specified ID
  * @param options.playerId ID of team to return 

  */
  getPlayerById: async (options) => {

    // Implement your business logic here...
    //
    // Return all 2xx and 4xx as follows:
    //
    // return {
    //   status: 'statusCode',
    //   data: 'response'
    // }

    // If an error happens during your business logic implementation,
    // you can throw it as follows:
    //
    // throw new Error('<Error message>'); // this will result in a 500

    var data = {
        "code": "<int64>",
        "status": "<string>",
        "message": "<string>",
        "response": "<object>",
        "links": "<array>"
      },
      status = '200';
    
    const playerContext = {
        "name": "https://schema.org/givenName",
        "surname": "https://schema.org/familyName",
        "contract_ends": "https://schema.org/Date"
    }

    let id = Number.parseInt(options.playerId);
    console.log(id);
    if (!Number.isInteger(id)) {
      data.code = 400;
      data.status = "Bad request";
      data.message = "Invalid id type";
      data.response = null;
      data.links = null;
      status = 400;
    } else {

      let player = await dbGetPlayerById(id);


      if (player === undefined) {
        data.code = 404;
        data.status = "Not found";
        data.message = "Could not find player with specified id";
        data.response = null;
        data.links = null;
      } else {
        player['@context'] = playerContext;
        data.code = 200;
        data.status = "OK";
        data.message = "Fetched player";
        data.response = player;
        data.links = [];
      }



    }

    return {
      status: status,
      data: data
    };
  },
};

function formatDate(date) {
  return date.toISOString().split('T')[0];
}

function linkFactory(href, rel, method) {
  let link = {};
  link.href = href;
  link.rel = rel;
  link.method = method;
  return link;
}

dbGetPlayers = async function () {
  let sql = `SELECT
              playerid,
              ign as player,
              playername as name,
              playersurname as surname,
              countryname as country,
              teamname as team,
              rolename as role,
              contractends as contract_ends
            FROM
              player LEFT JOIN team ON player.teamid = team.teamid
              JOIN country ON player.countryid = country.countryid
              NATURAL JOIN role
            ORDER BY
              playerid`;
  let players = (await db.query(sql)).rows;

  if (players.length == 0 || players == undefined)
    return undefined;

  players.forEach(player => {
    player.contract_ends = formatDate(player.contract_ends);
  });
  return players;
}

dbGetPlayerById = async function (id) {
  let sql = `SELECT
              playerid,
              ign as player,
              playername as name,
              playersurname as surname,
              countryname as country,
              teamname as team,
              rolename as role,
              contractends as contract_ends
            FROM
              player LEFT JOIN team ON player.teamid = team.teamid
              JOIN country ON player.countryid = country.countryid
              NATURAL JOIN role
            WHERE
              playerid = $1`;

  let res = (await db.query(sql, [id])).rows;

  if (res.length == 0 || res == undefined)
    return undefined;
  let player = res[0];
  player.contract_ends = formatDate(player.contract_ends);
  return player;
}