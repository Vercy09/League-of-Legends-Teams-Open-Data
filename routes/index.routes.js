const express = require('express');
const router = express.Router();
const fs = require('fs-extra');
const { Parser, transforms: { unwind } } = require('json2csv');
const db = require('../db/index');


router.get('/', function (req, res, next) {
    res.render('index', {
        title: 'Home',
        loggedin: req.oidc.isAuthenticated()
    });
});


function formatDate(date) {
    return date.toISOString().split('T')[0];
}
function formatString(str) {
    let result = str.charAt(0).toUpperCase() + str.slice(1);
    return result.split('_').join(' ');
}

router.get('/update', async function (req, res, next) {
    if(req.oidc.isAuthenticated()) {
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
        order by teamid
        `)).rows;

        teams.forEach(team => {
            team.created = formatDate(team.created);
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
            players.forEach(player => {
                if(player.teamid == team.teamid)
                {
                    delete player.teamid;
                    team.roster.push(player);
                }
                
            });
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
        teams.forEach(team => {
            delete team.teamid;
        });

        try {
            await fs.writeFile('./public/data/LoL_Teams.json', JSON.stringify(teams, null, 4))
            console.log('success!')
        } catch (err) {
            console.error(err)
        }
    

        const fields = ['name', 'acronym', 'headcoach',
        'roster.player', 'roster.name', 'roster.surname', 'roster.country', 'roster.role', 'roster.contract_ends',
        'created', 'domestic_titles', 'international_titles', 'org_location', 'league', 'sponsors'];
        const transforms = [unwind({ paths: ['roster', 'sponsors'] })];
        var parser = new Parser({ fields, transforms });
        var csv = parser.parse(teams);


        try {
            await fs.writeFile('./public/data/LoL_Teams.csv', csv)
            console.log('success!')
        } catch (err) {
            console.error(err)
        }

        res.redirect('/profile');
    } 
    else {
        res.sendStatus(401);
    }
    
});



module.exports = router;