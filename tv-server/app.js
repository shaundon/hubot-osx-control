var sys = require('sys');
var exec = require('child_process').exec;
var express = require('express');
var open = require('open');
var say = require('say');
var bodyParser = require('body-parser');
var app = express();
var port = 7428;

app.use(bodyParser());

console.log('Open for business on port ' + port);

app.get('/', function(req, res) {
	res.send(200, 'Server is running. You\'re all set!');
});

app.post('/webpage', function(req, res) {
	try {
	    console.log("/webpage received request to open " + req.param('url'));
		open(req.param('url'));
		res.send(200);
	}
	catch (ex) {
		console.log('ERROR: Could not open ' + req.param('url'));
		res.send(500, { error: 'Could not open.' });
	}
});

app.post('/speak', function(req, res) {
	try {
		console.log("/speak received request to say " + req.param('words'));
		var voice = "Alex";
		if (req.param('voice')) {
			voice = req.param('voice');
		}
		say.speak(voice, req.param('words'));
		res.send(200);
	}
	catch (ex) {
		console.log('ERROR: Could not say ' + req.param('words'));
		res.send(500, { error: 'Could not speak.' });
	}

});

app.post('/spotify', function(req, res) {
    try {
        console.log("/spotify received request for action " + req.param('action'));
        exec('osascript SpotifyControl.scpt ' + req.param('action'), function(error, stdout, stderr) {
            console.log(stdout);
            if (error !== null) {
                console.log('exec error: ' + error);
                res.send(500, {error: error});
            }
            else {
                res.send(200, {status: stdout});
            }
        });
    }
    catch (ex) {
        console.log('ERROR: Could not spotify ' + req.param('action'));
        res.send(500, { error: 'Could not spotify.' });
    }
});

app.listen(port);
