'use strict';

const express = require('express');


// Constants
const PORT = process.env.PORT || "8082";
const HOST = process.env.HOST || "0.0.0.0";
const VERSION = process.env.VERSION || "1.0.1";

// App
const app = express();
app.get('/', (req, res) => {
    res.send('<p><h1 align="center">Our Awesome Application!</h1>\n\n\n<h3 align="center">Version: '+VERSION+'</h3></p>');
});

app.listen(PORT, HOST);
console.log('Running on http://%s:%s',HOST,PORT);
