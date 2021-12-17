const {Pool} = require('pg');

let localDBInfo = {
    user: 'postgres',
    host: 'localhost',
    database: 'LoL_Teams',
    password: 'bazepodataka',
    port: 5432
};

let remoteDBInfo = {
    user: 'etokrrlfcsubmu',
    host: 'ec2-52-30-133-191.eu-west-1.compute.amazonaws.com',
    database: 'dcf0htq73frf29',
    password: '5a9b758f31538106b9d4459c30b338c882223f2268111e481fb87a5371cbb8c5',
    port: 5432,
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
