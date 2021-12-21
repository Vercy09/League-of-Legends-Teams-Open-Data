const db = require('../db/index');

module.exports = {
  /**
  * Returns array of team objects for all teams


  */





  getTeams: async (options) => {

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
        "response": "<array>",
        "links": "<array>"
      },
      status = '200';


    let teams = await dbGetTeams();


    if (teams.length == 0 || teams == undefined) throw new Error('Internal server error');


    data.code = 200;
    data.status = 'OK';
    data.message = 'Fetched all teams';
    data.response = teams;
    data.links = [];
    data.links.push(linkFactory("/", "teams", "POST"));
    data.links.push(linkFactory("/{teamId}", "team", "GET"));
    data.links.push(linkFactory("/{teamId}", "team", "PUT"));
    data.links.push(linkFactory("/{teamId}", "team", "DELETE"));
    data.links.push(linkFactory("/{teamId}/players", "players", "GET"));



    return {
      status: status,
      data: data
    };
  },

  /**
  * Pass a team object without id field to be added to the database. Returns team object added to the database with the teamId field.

  * @param options.teamPost.acronym required //
  * @param options.teamPost.created required //
  * @param options.teamPost.domestic_titles required //
  * @param options.teamPost.headcoach required // 
  * @param options.teamPost.international_titles required //
  * @param options.teamPost.league required
  * @param options.teamPost.name required //
  * @param options.teamPost.org_location required


  */
  addTeam: async (options) => {

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
        "response": "<array>",
        "links": "<array>"
      },
      status = '200';


    let team = {};

    team.teamname = options.teamPost.name;
    team.acronym = options.teamPost.acronym;
    team.headcoach = options.teamPost.headcoach;
    team.created = options.teamPost.created;
    team.domestictitles = options.teamPost.domestic_titles;
    team.internationaltitles = options.teamPost.international_titles;
    team.countryid = await dbGetCountryId(options.teamPost.org_location);
    team.leagueid = await dbGetLeagueId(options.teamPost.league);

    if (team.countryid == undefined) {
      data.code = 400;
      status = 400;
      data.status = "Bad request"
      data.message = "Specified team country is invalid or not supported"
      data.response = null;
      data.links = null;
      return {
        status: status,
        data: data
      };
    }

    if (team.leagueid == undefined) {
      data.code = 400;
      status = 400;
      data.status = "Bad request";
      data.message = "Specified team league is invalid or not supported";
      data.response = null;
      data.links = null;
      return {
        status: status,
        data: data
      };
    }

    let teamid = await dbAddTeam(team);
    if (teamid == undefined) {
      data.code = 400;
      status = 400;
      data.status = "Bad request"
      data.message = "Passed team data could not be added"
      data.response = null;
      data.links = null;
      return {
        status: status,
        data: data
      };
    }

    team.teamid = teamid;


    data.code = 200;
    data.status = "OK"
    data.message = "Added team";
    data.response = team;
    data.links = [];
    data.links.push(linkFactory("/", "teams", "GET"));
    data.links.push(linkFactory("/{teamId}", "team", "GET"));
    data.links.push(linkFactory("/{teamId}", "team", "PUT"));
    data.links.push(linkFactory("/{teamId}", "team", "DELETE"));
    data.links.push(linkFactory("/{teamId}/players", "players", "GET"));




    return {
      status: status,
      data: data
    };
  },

  /**
  * Returns a single team object with specified ID
  * @param options.teamId ID of team to return 

  */
  getTeamById: async (options) => {

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
        "response": "<array>",
        "links": "<array>"
      },
      status = '200';


    let id = Number.parseInt(options.teamId);
    if (!Number.isInteger(id)) {
      data.code = 400;
      data.status = "Bad request";
      data.message = "Invalid id type";
      data.response = null;
      data.links = null;
      status = 400;
    } else {

      let team = await dbGetTeamByID(id);


      if (team === undefined) {
        data.code = 404;
        data.status = "Not found";
        data.message = "Could not find team with specified id";
        data.response = null;
        data.links = null;
      } else {
        data.code = 200;
        data.status = "OK";
        data.message = "Fetched team";
        data.response = team;
        data.links = [];
        data.links.push(linkFactory("/", "team", "PUT"));
        data.links.push(linkFactory("/", "team", "DELETE"));
        data.links.push(linkFactory("/players", "players", "GET"));
      }



    }


    return {
      status: status,
      data: data
    };
  },

  /**
  * Updates specified fields of the team object
  * @param options.teamId ID of team to update 
  * @param options.team.acronym required
  * @param options.team.created required
  * @param options.team.domestic_titles required
  * @param options.team.headcoach required
  * @param options.team.international_titles required
  * @param options.team.league required
  * @param options.team.name required
  * @param options.team.org_location required
  * @param options.team.roster
  * @param options.team.sponsors
  * @param options.team.teamid required

  */
  updateTeam: async (options) => {

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

    var data = {},
      status = '400';


    let id = Number.parseInt(options.teamId);
    if (!Number.isInteger(id)) {
      data.code = 400;
      data.status = "Bad request";
      data.message = "Invalid id type";
      data.response = null;
      data.links = null;
      status = 400;
    } else {

      let team = await dbGetTeamByID(id);


      if (team === undefined) {
        data.code = 404;
        data.status = "Not found";
        data.message = "Could not find team with specified id";
        data.response = null;
        data.links = null;
      } else {
        let listSql = [];
        let listData = [];
        try {
          if (options.team.name != undefined) {
            listSql.push('teamname');
            listData.push(options.team.name);
          }

          if (options.team.acronym != undefined) {
            listSql.push('teamacronym');
            listData.push(options.team.acronym);
          }

          if (options.team.headcoach != undefined) {
            listSql.push('headcoach');
            listData.push(options.team.headcoach);
          }

          if (options.team.created != undefined) {
            listSql.push('created');
            listData.push(options.team.created);
          }

          if(options.team.domestic_titles != undefined) {
            let domestictitles = Number.parseInt(options.team.domestic_titles);
            if (domestictitles != undefined) {
              if(!Number.isInteger(domestictitles)) throw new Error("Invalid data type");
              listSql.push('domestictitles');
              listData.push(domestictitles);
            }
          }
          

          if(options.team.international_titles != undefined) {
            let internationaltitles = Number.parseInt(options.team.international_titles);
            if (internationaltitles != undefined) {
              if(!Number.isInteger(internationaltitles)) throw new Error("Invalid data type");
              listSql.push('internationaltitles');
              listData.push(internationaltitles);
            }
          }
          

          if(options.team.org_location != undefined) {
            let countryid = await dbGetCountryId(options.team.org_location);
            if (countryid != undefined) {
              listSql.push('countryid');
              listData.push(countryid);
            } else throw new Error("Specified team country is invalid or not supported");
          }
          
          if(options.team.league != undefined) {
            let leagueid = await dbGetLeagueId(options.team.league);
            if (leagueid != undefined) {
              listSql.push('leagueid');
              listData.push(leagueid);
            } else throw new Error("Specified team league is invalid or not supported");
          }
          

          if(listSql.length == 0) throw new Error("Some data must be provided");

          let dataStr = '';
          for(let i = 1; i <= listSql.length; i++) {
              if(i != listSql.length)
                dataStr += '$' + i + ', ';
              else dataStr += '$' + i;
          }

          let sql = `UPDATE team SET (${listSql.join(', ')}) = (${dataStr})
                     WHERE teamid = ${id}`;
          console.log(sql);
          await db.query(sql, listData);
          data.code = 200;
          data.status = 'OK';
          data.message = "Successfuly updated the team"
          data.links = [];
          data.links.push(linkFactory("/", "team", "GET"));
          data.links.push(linkFactory("/", "team", "DELETE"));
          data.links.push(linkFactory("/players", "players", "GET"));

        } catch (err) {
          data.code = 400;
          data.status = "Bad request";
          data.message = err.message;
          data.response = null;
          data.links = null;
          status = 400;
        }
        
      }

    }



    return {
      status: status,
      data: data
    };
  },

  /**
  * Deletes a team with specified ID
  * @param options.teamId ID of team to delete 

  */
  deleteTeam: async (options) => {

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
      },
      status = '200';


    let id = Number.parseInt(options.teamId);


    if (!Number.isInteger(id)) {
      data.code = 400;
      data.status = "Bad request";
      data.message = "Invalid id type";
      status = 400;
    } else {

      let teamid = await dbDeleteTeam(id);

      if (teamid === undefined) {
        data.code = 404;
        data.status = "Not found";
        data.message = "Could not find team with specified id";
      } else {
        data.code = 200;
        data.status = "OK";
        data.message = "Deleted team";
      }

    }

    return {
      status: status,
      data: data
    };
  },

  /**
  * Gets a list of player objects for team with ID
  * @param options.teamId ID of team to get the players from 

  */
  getPlayersForTeam: async (options) => {

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
        "response": "<array>",
        "links": "<array>"
      },
      status = '200';





    let id = Number.parseInt(options.teamId);

    if (!Number.isInteger(id)) {
      data.code = 400;
      data.status = "Bad request";
      data.message = "Invalid id type";
      data.response = null;
      data.links = null;
      status = 400;
    } else {

      let players = await dbGetPlayersForTeam(id);


      if (players === undefined) {
        data.code = 404;
        data.status = "Not found";
        data.message = "Could not find team with specified id";
        data.response = null;
        data.links = null;
      } else {
        data.code = 200;
        data.status = "OK";
        data.message = "Fetched team's players";
        data.response = players;
        data.links = [];
      }
    }



    return {
      status: status,
      data: data
    };
  }
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




dbGetTeamByID = async function (id) {
  let res = (await db.query(`
  select 
    team.teamid,
    teamname as name, 
    teamacronym as acronym, 
    headcoach,
    created,	
    domestictitles as domestic_titles, 
    internationaltitles as international_titles, 
    countryname as org_location, 
    leagueacronym as league
    --sponsors
  from 
    team natural join 
    country natural join 
    league
  where
      team.teamid = ${id}
  `)).rows;

  if (res.length == 0 || res == undefined)
    return undefined;



  let team = res[0];
  team.created = formatDate(team.created);

  return team;
}


dbGetTeams = async function () {
  let teams = (await db.query(`
  select 
      team.teamid,
     teamname as name, 
    teamacronym as acronym, 
    headcoach,
    created,	
    domestictitles as domestic_titles, 
    internationaltitles as international_titles, 
    countryname as org_location, 
    leagueacronym as league
    --sponsors
  from 
    team natural join 
    country natural join 
    league
  order by
      team.teamid
  `)).rows;

  teams.forEach(team => {
    team.created = formatDate(team.created);
  });

  return teams;
}

dbAddTeam = async function (team) {
  let sql =
    `INSERT INTO team(teamname, teamacronym, headcoach, created, domestictitles, internationaltitles, countryid, leagueid)
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
     RETURNING team.teamid`;
  let res;
  try {
    res = (await db.query(sql, Object.values(team))).rows;
  } catch (err) {
    return undefined;
  }
  if (res.length == 0 || res == undefined)
    return undefined;

  return res[0].teamid;

}

dbGetCountryId = async function (country) {
  let sql = `
              SELECT countryid
              FROM country
              WHERE countryname = $1
              `;
  let res = (await db.query(sql, [country])).rows;
  if (res.length == 0 || res == undefined)
    return undefined;
  return res[0].countryid;
}

dbGetLeagueId = async function (league) {
  let sql = `
            SELECT leagueid
            FROM league
            WHERE leagueacronym = $1
            `;
  let res = (await db.query(sql, [league])).rows;
  if (res.length == 0 || res == undefined)
    return undefined;

  return res[0].leagueid;
}

dbDeleteTeam = async function (id) {
  let sql = `
            SELECT teamid
            FROM team
            WHERE teamid = $1
            `;
  let res = (await db.query(sql, [id])).rows;
  if (res.length == 0 || res == undefined)
    return undefined;

  sql = `DELETE
         FROM team
         WHERE teamid = $1
         `;
  await db.query(sql, [id]);
  return res[0].teamid;

}

dbGetPlayersForTeam = async function (id) {
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
              player JOIN team ON player.teamid = team.teamid
              JOIN country ON player.countryid = country.countryid
              NATURAL JOIN role
            WHERE
              player.teamid = $1
            ORDER BY
              playerid`;
  let players = (await db.query(sql, [id])).rows;
  if (players.length == 0 || players == undefined)
    return undefined;

  players.forEach(player => {
    player.contract_ends = formatDate(player.contract_ends);
  });

  return players;
}