hubot-osx-control
=================

## What does this do?

[Hubot](https://hubot.github.com/)'s great. You love Hubot. But wouldn't it be awesome if you could control a Mac with him? Now you can :)

In our office, we have a TV on our DevOps office wall connected to a Mac Mini, so we use this to make webpages open and control Spotify, all from the comfort of our [Flowdock](https://www.flowdock.com/) chat.

## How does it work?

It's super simple. Hubot sends HTTP POST requests to the Mac, which is running a simple node server. The Mac's configured to perform actions when it receives these requests.

## Usage

You'll need the following things:

* A Hubot (not running on the Mac - the whole point of this is so they can talk over a network!)
* A Mac

### Step One - Get the server running

Get the `tv-server` folder, and put it somewhere on the Mac. Open your favourite OS X terminal app, navigate to wherever you put the folder, then run `./start` to start the server. If you run into any problems, you probably don't have node or npm installed.

The terminal output will say 'open for business on port 7428'. Open your favourite browser and go to [http://localhost:7428](http://localhost:7428). You should see a message indicating that the server is set up.

Now you may need to open up your Mac on the network, so that Hubot can speak to it. You can find several tutorials for doing this on the web. Once you've set this up, you'll be able to go to *http://YOUR_MACS_HOSTNAME_HERE:7428* on another computer and still see the success message.

### Step Two - Install the Hubot script

Take the `osx-control.coffee` file, and drop it into your Hubot's `scripts` folder. Open the file in a text editor and change the line near the top, the one beginning with `MAC_URL = ` so that it points to your Mac on the network. For example you might use `MAC_URL = http://some.fake.address:7428/`. **The trailing slash is important, make sure it's there**.

### Step Three - Try it out

Rebuild and deploy your updated Hubot, and try talking to the Mac. Commands are:

* `hubot tv me <url>` - Opens a webpage in the Mac's default browser. This also works for URI schemes to open apps. Make sure you include the *http://* or *https://* part if it's a webpage.
* `hubot skype me <users>` - Starts a call with *<users>* on the Mac's Skype app. Obviously you'll need Skype installed to do this :) *<users>* is a comma separated list of usernames to call, e.g. `hubot skype me userA,userB`.
* `hubot speak <sentence>` - Uses text to speech on the Mac to make it speak *<sentence>*.
* `hubot spotify <command>` - Controls Spotify. You can use `hubot spotify help` to get a list of commands available.
* `hubot party` - Starts a party! You'll need Spotify installed for this one. The Mac will open a fullscreen [YouTube video](https://www.youtube.com/v/-2eQhhMvi-U&autoplay=1) of a cool light effect, and play a random party song on Spotify.

## Credits

The Spotify control is powered by https://github.com/dronir/SpotifyControl. Thanks [@dronir](https://github.com/dronir/)!

## Contributing

I'd love contributions, feel free to create a pull request with some exciting new functionality.
