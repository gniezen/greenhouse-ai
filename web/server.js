const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

// configure our express instance with some body-parser settings
// including handling JSON data
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// this is where we'll handle our various routes from
const routes = require('./routes/routes.js')(app, fs);

// finally, launch our server on port 3001.
const server = app.listen(3001, () => {
  console.log('listening on port %s...', server.address().port);
});