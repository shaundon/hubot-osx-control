# Allows Hubot to message our TV and ask her to do things.
#
# hubot tv me <url>
# hubot skype me <usernames>
# hubot speak <sentence>
# hubot party
# hubot spotify <action>
#

module.exports = (robot) ->

  # Place the URL of your Mac here. Leave the trailing
  # slash, it's important.
  MAC_URL = "http://YOUR_URL_HERE:7428/"

  #
  ## OPEN WEBPAGES .
  #

  robot.respond /tv me (.*)/i, (msg) ->
    pageToOpen = msg.match[1]
    postData = JSON.stringify({
      url: pageToOpen
    })

    robot.http(MAC_URL + "webpage")
      .header('Content-Type', 'application/json')
      .post(postData) (err, res, body) ->
        if (err)
          msg.send "Encountered an error :( #{err}"
        else
	        msg.send "Asking the Mac to open " + pageToOpen


  #
  ## MAKE SKYPE CALLS
  #

  robot.respond /skype me (.*)/i, (msg) ->
    peopleToCall = msg.match[1]
    pageToOpen = "skype:" + peopleToCall + "?call"
    postData = JSON.stringify({
      url: pageToOpen
    })

    robot.http(MAC_URL + "webpage")
      .header('Content-Type', 'application/json')
      .post(postData) (err, res, body) ->
        if (err)
          msg.send "Encountered an error :( #{err}"
        else
          msg.send "Asking the Mac to start a Skype call"
  #
  ## DISCO MODE
  #

  robot.respond /party/i, (msg) ->

    disco_songs = [
      'spotify:track:6ol4ZSifr7r3Lb2a9L5ZAB#0:28' # Call me maybe.
      'spotify:track:31SDI3t7B112VriaGvxBXK#0:04' # Saturday night.
      'spotify:track:7LL40F6YdZgeiQ6en1c7Lk#0:23' # Robot Rock.
      'spotify:track:5lWFrW5T3JtxVCLDb7etPu' # Bad (Michael Jackson)
      'spotify:track:5MNKmxOlsF1HtUA9PtJVhC' # Rhythm of the night.
      'spotify:track:6Kj0IpbXBHDgO5UBKpoEn2#0:15' # This is how we do it.
      'spotify:track:1d2O0FAl7OrNNu7Ed3bGrK' # What is love
    ]

    # Pick a random song.
    postData = JSON.stringify({
      url: disco_songs[Math.floor(Math.random()*disco_songs.length)]
    })

    # Ask TV to play it.
    robot.http(MAC_URL + "webpage")
      .header('Content-Type', 'application/json')
      .post(postData) (err, res, body) ->

    # YouTube video of a strobe light.
    postData = JSON.stringify({
      url: "https://www.youtube.com/v/-2eQhhMvi-U&autoplay=1"
    })

    # Ask TV to open it.
    robot.http(MAC_URL + "webpage")
      .header('Content-Type', 'application/json')
      .post(postData) (err, res, body) ->

    msg.send "Initiating party mode (Dev version)"

  #
  ## MAKE THE TEXT TO SPEECH ON THE TV SAY THINGS
  #

  robot.respond /speak (.*)/i, (msg) ->
    sentence = msg.match[1]
    postData = JSON.stringify({
      words: sentence
    })

    robot.http(MAC_URL + "speak")
    .header('Content-Type', 'application/json')
    .post(postData) (err, res, body) ->
      if (err)
        msg.send "Encountered an error :( #{err}"
      else
        msg.send "Asking the dev room TV to speak"

  #
  ## CONTROL SPOTIFY.
  #

  robot.respond /spotify (.*)/i, (msg) ->
    spotifyCommand = msg.match[1]
    postData = JSON.stringify({
      action: spotifyCommand
    })

    if spotifyCommand == 'help'
      msg.send "Spotify commands:\n\n#{robot.name} spotify play - Start playing\n#{robot.name} spotify pause - Pause playback\n#{robot.name} spotify next - Next track\n#{robot.name} spotify previous - Previous track\n#{robot.name} spotify info - Current song info\n#{robot.name} spotify volume <level> - Level is 0-100\n#{robot.name} spotify shuffle <level> - Toggle shuffle\n#{robot.name} spotify repeat <level> - Toggle repeat\n#{robot.name} spotify jump <seconds> - Jump to <seconds> seconds in the track. E.g. spotify jump 30\n\nTo play a specific song, get the Spotify URI by right clicking on the song and selecting 'Copy Spotify URI', and append it to the 'play' command. For example:\n#{robot.name} spotify play spotify:track:3ixTiPABjqkBKPocxq6oIe"
    else
      robot.http(MAC_URL + "spotify")
      .header('Content-Type', 'application/json')
      .post(postData) (err, res, body) ->
        if (err)
          msg.send "Encountered an error :( #{err}"
        else
          msg.send JSON.parse(body).status
