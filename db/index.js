require('dotenv').config();
const {Pool} = require('pg');

let localDBInfo = {
    user: 'postgres',
    host: 'localhost',
    database: 'LoL_Teams',
    password: 'bazepodataka',
    port: 5432
};

let remoteDBInfo = {
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT,
    ssl: {
        rejectUnauthorized: false
    }
}


let dbInfo = remoteDBInfo;

const pool = new Pool(dbInfo);

module.exports = {
    query: (text, params) => {
        const start = Date.now();
        return pool.query(text, params)
            .then(res => {
                const duration = Date.now() - start;
                //console.log('executed query', {text, params, duration, rows: res.rows});
                return res;
            });
    },
    pool: pool,
    dbInfo: dbInfo
}
