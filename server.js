//module import
const express = require('express');
const app = express();
const path = require('path');
const pg = require('pg');
const db = require('./db');

//uvoz modula s definiranom funkcionalnosti ruta
const indexRouter = require('./routes/index.routes');
const datatableRouter = require('./routes/datatable.routes');

//middleware - predlošci (ejs)
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//middleware - statički resursi
app.use(express.static(path.join(__dirname, 'public')));

//middleware - dekodiranje parametara
app.use(express.urlencoded({ extended: true }));

//definicija ruta
app.use('/', indexRouter);
app.use('/data', datatableRouter);

//pokretanje poslužitelja na portu 3000
app.listen(3000);