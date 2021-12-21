//module import
const express = require('express');
const app = express();
const path = require('path');
const api = '/api/v1';

//uvoz modula s definiranom funkcionalnosti ruta
const indexRouter = require('./routes/index.routes');
const datatableRouter = require('./routes/datatable.routes');


//API routers
const teamsRouter = require('./routes/api/teams.route');
const playersRouter = require('./routes/api/players.route');
const openapiRouter = require('./routes/api/openapi.route');


//middleware - predlošci (ejs)
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//middleware - statički resursi
app.use(express.static(path.join(__dirname, 'public')));

//middleware - dekodiranje parametara
app.use(express.urlencoded({ extended: true }));

//definicija ruta
app.use('/', indexRouter);
app.use('/datatable', datatableRouter);

//API route definition
app.use(`${api}/teams`, teamsRouter);
app.use(`${api}/players`, playersRouter);
app.use(`${api}/openapi`, openapiRouter);


//pokretanje poslužitelja na portu 3000
app.listen(3000);