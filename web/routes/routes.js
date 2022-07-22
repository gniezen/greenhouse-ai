const observationRoutes = require('./observations');

const appRouter = (app, fs) => {
  // we've added in a default route here that handles empty routes
  // at the base API url
  /*
  app.get('/', (req, res) => {
    res.send('welcome to the greenhouse ai server');
  });
  */

  // run our user route module here to complete the wire up
  observationRoutes(app, fs);
};

module.exports = appRouter;