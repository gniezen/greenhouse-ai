const json2html = require('node-json2html');

const observationRoutes = (app, fs) => {

  const dataPath = './data/observations.json';
  let template = {"<>":"tr","html":[
        {"<>":"td","html":"${date}"},
        {"<>":"td","html":"${time}"},
        {"<>":"td","html":"${observation}"},
        {"<>":"td","html":"${battery} V"}
      ]};

  // refactored helper methods
  const readFile = (
    callback,
    returnJson = false,
    filePath = dataPath,
    encoding = 'utf8'
  ) => {
    fs.readFile(filePath, encoding, (err, data) => {
      if (err) {
        throw err;
      }

      callback(returnJson ? JSON.parse(data) : data);
    });
  };

  const writeFile = (
    fileData,
    callback,
    filePath = dataPath,
    encoding = 'utf8'
  ) => {
    fs.writeFile(filePath, fileData, encoding, err => {
      if (err) {
        throw err;
      }

      callback();
    });
  };

  // READ
  app.get('/observations', (req, res) => {
    readFile(data => {
      const sorted = [];
      Object.keys(data).sort().map(key => {
      	data[key].battery /= 1000;
      	sorted.push(data[key]); // sort by timestamp
      }); 
      
      let html = `
      	<!doctype html>
      	<html lang="en">
      	  <head>
      	    <meta charset="utf-8">
      	    <meta name="viewport" content="width=device-width, initial-scale=1">
      	    <title>Plant Status</title>
      	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
      	  </head>
      	  <body>
      	    <table class="table">
    	    <thead>
    	       <tr>
    	        <th scope="col">Date</th>
    	        <th scope="col">Time</th>
    	        <th scope="col">Observation</th>
    	        <th scope="col">Battery</th>
    	       </tr>
    	    </thead>
      	    <tbody>
      	       ${json2html.render(sorted,template)}
      	    </tbody>
      	    </table>
      	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
      	  </body>
      	</html>
      	`;
      res.send(html);
    }, true);
  });

  // CREATE
  app.post('/observations', (req, res) => {
    readFile(data => {
      // Note: this needs to be more robust for production use. 
      // e.g. use a UUID or some kind of GUID for a unique ID value.
      const newObservationId = Date.now().toString();
  
      // add the new observation
      data[newObservationId] = req.body;
  
      writeFile(JSON.stringify(data, null, 2), () => {
        res.status(200).send('new observation added');
      });
    }, true);
  });

  // UPDATE
  app.put('/observations/:id', (req, res) => {
    readFile(data => {
      // add the new observation
      const observationId = req.params['id'];
      data[observationId] = req.body;
  
      writeFile(JSON.stringify(data, null, 2), () => {
        res.status(200).send(`observations id:${observationId} updated`);
      });
    }, true);
  });

  // DELETE
  app.delete('/observations/:id', (req, res) => {
    readFile(data => {
      // delete the observation
      const observationId = req.params['id'];
      delete data[observationId];
  
      writeFile(JSON.stringify(data, null, 2), () => {
        res.status(200).send(`observation id:${observationId} removed`);
      });
    }, true);
  });
};

module.exports = observationRoutes;