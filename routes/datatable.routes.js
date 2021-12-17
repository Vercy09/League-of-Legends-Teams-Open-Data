const express = require('express');
const router = express.Router();
const db = require('../db/index');
const jsonToTable = require('json-to-table');

router.get('/', async function (req, res, next) {
   
    res.render('datatable', {
        title: 'Data'
    });
    
});



function formatDate(date) {
    return date.toISOString().split('T')[0];
}
function formatString(str) {
    let result = str.charAt(0).toUpperCase() + str.slice(1);
    return result.split('_').join(' ');
}
function get_table(data) {
    let result = ['<table border=1 style="width:100%" class="table table-striped table-bordered">'];
    for(let i = 0; i < data.length; i++) {
        if (i == 0) result.push('<tr style="font-weight:bold">');
        else result.push('<tr>');
        for(let cell of data[i]){
            if (i == 0) result.push(`<td>${formatString(cell)}</td>`);
            else result.push(`<td>${cell}</td>`);
        }
        result.push('</tr>');
    }
    result.push('</table>');
    return result.join('\n');
  }



router.get('/data', async function (req, res, next) {
    let teams = (await db.query(`
    select 
        team.teamid,
 	    teamname as name, 
	    teamacronym as acronym, 
	    --concat(coachname, ' "', headcoach, '" ', coachsurname) as headcoach,
        headcoach,
	    --roster
	    created,	
	    domestictitles as domestic_titles, 
	    internationaltitles as international_titles, 
	    countryname as org_location, 
	    leagueacronym as league
	    --sponsors
    from 
	    team natural join 
	    country natural join 
	    league --inner join 
	    --headcoach on(team.teamid = headcoach.teamid)
    `)).rows;

    teams.forEach(team => {
        team.created = formatDate(team.created);
        team.rosterTable = [];
        team.roster = [];
        team.sponsors = [];
    });

    let players = (await db.query(`
    select 
	    ign as player,
	    playername as name,
	    playersurname as surname,
	    countryname as country,
	    rolename as role,
	    contractends as contract_ends,
        teamid
    from 
	    player natural join 
	    country natural join 
	    role
    `)).rows

    
    players.forEach(player => {
        player.contract_ends = formatDate(player.contract_ends);
    });
    
    
    teams.forEach(team => {
        let roster = [];
        players.forEach(player => {
            if(player.teamid == team.teamid)
            {
                delete player.teamid;
                roster.push(player);
                team.roster.push(player);
            }
            
        });
        team.rosterTable.push(get_table(jsonToTable(roster)));
    });


    let sponsors = (await db.query(`
    select 
	    teamid,
	    sponsorname as sponsor_name
    from 
	    sponsoredby natural join 
	    sponsor
    `)).rows
   
    teams.forEach(team => {
        sponsors.forEach(sponsor => {
            if(team.teamid == sponsor.teamid) {
                team.sponsors.push(sponsor.sponsor_name);
            }
        });
    });

    res.json(teams);
});

module.exports = router;