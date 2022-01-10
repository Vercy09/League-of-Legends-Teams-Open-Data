//module import
const express = require('express');
const app = express();
const path = require('path');
require('dotenv').config();
const {auth} = require('express-openid-connect');
const api = '/api/v1';

//uvoz modula s definiranom funkcionalnosti ruta
const indexRouter = require('./routes/index.routes');
const datatableRouter = require('./routes/datatable.routes');
const profileRouter = require('./routes/profile.routes');


//API routers
const teamsRouter = require('./routes/api/teams.route');
const playersRouter = require('./routes/api/players.route');
const openapiRouter = require('./routes/api/openapi.route');

//middleware - auth
app.use(
    auth({
        authRequired: false,
        auth0Logout: false,
        issuerBaseURL: process.env.ISSUER_BASE_URL,
        baseURL: process.env.BASE_URL,
        clientID: process.env.CLIENT_ID,
        secret: process.env.SECRET
    })
);


//middleware - predlošci (ejs)
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//middleware - statički resursi
app.use(express.static(path.join(__dirname, 'public')));

//middleware - dekodiranje parametara
app.use(express.urlencoded({ extended: true }));

//definicija ruta
// app.get('/', (req, res) => {
//     res.send(req.oidc.isAuthenticated() ? 'Logged in' : 'Logged out');
// });

app.use('/', indexRouter);
app.use('/datatable', datatableRouter);
app.use('/profile', profileRouter);


//API route definition
app.use(`${api}/teams`, teamsRouter);
app.use(`${api}/players`, playersRouter);
app.use(`${api}/openapi`, openapiRouter);


//pokretanje poslužitelja na portu 3000
app.listen(3000);