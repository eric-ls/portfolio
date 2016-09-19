###
Artist Playlists v0.05
7/21/2016
###

Framer.Info =
	title: "Prototype 2"
	author: "Eric Liang"
	twitter: "hiEricLiang"
	description: "Second prototype for artist channel, tested on 8/1/16 soundcheck."
	
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.disable()


{AudioPlayer} = require "audio"

# Defining global variables and other stuff
full_width = Framer.Device.screen.width
full_height = Framer.Device.screen.height
Canvas.backgroundColor = "#F7F7F7"

generatePlayingBarText = (song, artist) ->
	return "<span >#{song} &middot; </span><span style='color: #BBB'>#{artist}</span>"
	
artist_intro =
	id: "intro"
	name: "Artist Introduction"
	artist: "Meghan Trainor"
	url: ""
	video: ""
	
media = [{ 
		id: "no"
		name: "NO"
		artist: "Meghan Trainor"
		url: "media/no.mp3"
		video: "media/no.mp4"
		comment: "NO - its on the radio!!!"
	}, {
		id: "right_here"
		name: "Right Here (Departed)"
		artist: "Brandy"
		url: "media/right_here.mp3"
		video: "media/right_here.mp4"
		comment: "my DAD joined us on stage last night!! <3"
	}, {
		id: "bass"
		name: "All About That Bass"
		artist: "Meghan Trainor"
		url: "media/bass.mp3"
		video: "media/bass.mp4"
		comment: ""
	}, {
		id: "breakfree"
		name: "Break Free"
		artist: "Ariana Grande feat. Zedd"
		url: "media/break_free.mp3"
		video: "media/tour.mp4"
		comment: "my tour JAM! check out the video!"
	}
]

# Initial Page

# Profile Page scroll component
profile_scroll = new ScrollComponent
	width: full_width, height: full_height
	backgroundColor: ""
	scrollHorizontal: false

profile = new Layer
	width: full_width, height: 2966
	image: "images/profile.png"
	parent: profile_scroll.content

profile.on Events.Tap, ->
	playlist_trigger.animate
		properties: opacity: 1
		time: 0.2
	Utils.delay 0.3, ->
		playlist_trigger.animate
			properties: opacity: 0
			time: 0.2

playlist_trigger = new Layer
	width: 750, height: 293
	y: 765
	backgroundColor: "rgba(52, 152, 219,0.3)"
	borderColor: "rgba(52, 152, 219,1.0)"
	parent: profile_scroll.content
	borderWidth: 3, borderRadius: 7
	opacity: 0

playlist_trigger.onClick ->
	song_scroll.states.switch("show")

# Create Song Scroll Component
song_scroll = new ScrollComponent
	backgroundColor: "#181818"
	x: full_width, y: Align.center
	scrollHorizontal: false
	width: full_width, height: full_height
	contentInset: bottom: 100

song_scroll.states.animationOptions = 
	time: 0.3
	curve: "ease-in-out"

song_scroll.states.add
	show: x: Align.center
	hide: x: full_width

artist_pic = new Layer
	width: 750, height: 1452
	image: "images/meghan.gif"
	parent: song_scroll.content

song_bg = new Layer
	parent: song_scroll.content
	y: 1019
	width: 750
	height: 1127
	backgroundColor: "rgba(24, 24, 24, 1)"

alpha_gradient = new Layer
	width: full_width, height: 1019
	parent: song_scroll.content
	y: Align.top, x: Align.center
	
alpha_gradient.style.background = "-webkit-linear-gradient(top, rgba(0,0,0,0) 0%,rgba(24,24,24,1) 100%)"

play_btn = new Layer
	x: Align.center
	y: 857
	width: 310
	height: 96
	image: "images/play_btn.png"
	parent: song_scroll.content

play_btn.on Events.TouchStart, ->
	this.opacity = 0.85
	this.scale = 0.97
play_btn.on Events.TouchEnd, ->
	this.opacity = 1
	this.scale = 1
	
playlist_artist = new Layer
	width: 750
	x: Align.center, y: 605
	backgroundColor: ""
	html: "Meghan Trainor's"
	parent: song_scroll.content
	height: 51

playlist_artist.style = 
	"fontWeight": 600
	"fontSize": "45px"
	"textAlign": "center"

playlist_description = new Layer
	width: 370
	x: Align.center, y: 790
	backgroundColor: ""
	opacity: 0.9
	html: "Inspiration, fresh tracks and videos, direct from the artist!"
	parent: song_scroll.content
	height: 51
	visible: false

playlist_description.style = 
	"fontWeight": 400
	"fontSize": "28px"
	"lineHeight": 1.4
	"textAlign": "center"

playlist_title = new Layer
	width: full_width
	backgroundColor: ""
	height: 116
	html: "SELECT"
	y: 725
	parent: song_scroll.content

playlist_title.style = 
	"fontWeight": 700
	"fontStyle": "italic"
	"fontSize": "140px"
	"letterSpacing": "15px"
	"textAlign": "center"
	
top_nav = new Layer
	width: 730
	height: 88
	image: "images/top_nav.png"
	x: Align.center, y: 10
	parent: song_scroll.content

back_trigger = new Layer
	parent: song_scroll.content
	height: 153
	width: 120
	backgroundColor: ""
	
back_trigger.onClick ->
	song_scroll.states.switch("hide")

# Songs
break_free = new Layer
	name: first_song
	width: 744
	height: 228
	image: "images/break_free.png"
	parent: song_scroll.content
	y: 1064

_no = new Layer
	width: 750
	height: 234
	image: "images/no.png"
	parent: song_scroll.content
	y: 1019
	
lose_you = new Layer
	width: 750
	height: 152
	image: "images/lose_you.png"
	parent: song_scroll.content

bass = new Layer
	width: 750
	height: 152
	image: "images/bass.png"
	parent: song_scroll.content

right_here = new Layer
	width: 750
	height: 224
	image: "images/right_here.png"
	parent: song_scroll.content

dont_stop = new Layer
	width: 750
	height: 152
	image: "images/dont_stop.png"
	parent: song_scroll.content

# Quick functions to automate song list positioning
songs = [break_free, right_here, bass, lose_you, dont_stop]
prev_songs = [_no]
first_song = _no
gutter = 8

calcPrevHeight = ->
	total = 0
	for s in prev_songs
		total += s.height + gutter
	return total

for s in songs
	prev_height = calcPrevHeight()
	s.y = prev_height + first_song.y
	prev_songs.push(s)

bottom_nav = new Layer
	width: 750
	height: 97
	y: Align.bottom
	image: "images/bottom_nav.png"
	parent: song_scroll
	
bottom_nav.on Events.Tap, (e) ->
	e.stopPropagation()

playing_bar = new Layer
	width: 750
	height: 90
	image: "images/playing_bar.png"
	parent: song_scroll
	y: Align.bottom(-97)
	visible: false

playing_bar_song = new Layer
	parent: playing_bar
	html: generatePlayingBarText("Song Title", "Song Artist")
	backgroundColor: ""
	width: 500
	x: 90, y: 14

playing_bar.style.fontSize = "26px"
playing_bar.style.fontWeight = "400"
playing_bar.style.color = "#FC42A8"

playing_bar.on Events.Tap, ->
	show_play_screen()


intro_popup = new Layer
	width: 594, height: 176
	image: "images/intro_popup.png"
	parent: song_scroll.content
	y: 900, x: 78
	scale: 0.7
	opacity: 0

intro_popup.states.animationOptions = 
	time: 0.3
	curve: "spring(400, 25, 0)"

intro_popup.states.add
	show:
		opacity: 1
		y: 985
		scale: 1
	hide:
		opacity: 0
		y: 900
		scale: 0.7

intro_popup.on Events.Tap, (e) ->
	this.states.switch("hide")
	e.stopPropagation()

		
song_scroll.on Events.StateDidSwitch, (from, to, states) ->
	if to == "show"
		Utils.delay 0.3, ->
			intro_popup.states.switch("show")
	else
		intro_popup.states.switch("hide")

thumbnail = new Layer
	image: "images/thumbnail.gif"
	x: 24, y: 776
	width: 220, height: 220
	shadowSpread: 2
	shadowColor: "rgba(0,0,0,0.62)"
	shadowBlur: 46
	parent: profile_scroll.content

# Song Screen layers
song_screen = new Layer
	opacity: 0
	x: Align.center
	y: full_height
	width: full_width
	height: full_height
	backgroundColor: "#181818"

video = new VideoLayer
	x: Align.center
	y: Align.center
	scale: 1.88
	width: 1280
	height: 720
	video: "media/intro.mp4"
	parent: song_screen

video.classList.add("video")
video.player.volume = 0
video.player.muted = true

video_gradient_top = new Layer
	width: 750
	height: 153
	parent: song_screen
	style:
		"background": "-webkit-linear-gradient(bottom, rgba(0,0,0,0) 0%,rgba(24,24,24,0.2) 100%)"

video_gradient_bot = new Layer
	opacity: 0
	width: 750, height: 153
	parent: song_screen
	style:
		"background": "-webkit-linear-gradient(top, rgba(0,0,0,0) 0%,rgba(24,24,24,0.4) 100%)"
	y: 1181

video_gradient_bot.states.animationOptions = 
	time: 0.4
video_gradient_bot.states.add
	show: opacity: 1
	hide: opacity: 0

video_comment = new Layer
	x: 118
	width: 607, height: 97
	backgroundColor: ""
	html: "from Meghan Trainor"
	parent: video_gradient_bot
	style: 
		fontWeight: "500"
		fontSize: "30px"
		lineHeight: "1.3"
	y: 67
		
meghan_pic = new Layer
	width: 66
	height: 66
	image: "images/meghan_pic.png"
	parent: video_gradient_bot
	y: 54
	x: 26


song_screen_components = new Layer
	width: full_width
	height: full_height
	backgroundColor: ""
	parent: song_screen

gradient_bg = new Layer
	width: full_width
	height: full_height
	parent: song_screen_components
	style:
		"background": "-webkit-linear-gradient(top, rgba(0,0,0,0) 0%,rgba(24,24,24,1) 100%)"

instruction_prompt = new Layer
	html: "Tap anywhere for video"
	backgroundColor: "rgba(255, 255, 255, 0.8)"
	color: "black"
	parent: song_screen_components
	x: 226, y: 43
	width: 299, height: 47
	style:
		"border-radius": "8px"
		"font-size": "24px"
		"font-weight": "600"
		"padding": "8px 15px"
		"text-align": "center"

title = new Layer
	x: Align.center, y: 1038
	height: 122, width: full_width
	parent: song_screen_components
	backgroundColor: ""
	html: "Playlist Intro"
	style:
		fontSize: "50px"
		fontWeight: "700"
		textAlign: "center"
		lineHeight: "1.3"
title.states.animationOptions = time: 0.2
title.states.add
	intro: y: 1038
	song: y: 890
		
artist = new Layer
	x: Align.center, y: 983
	height: 122, width: full_width
	parent: song_screen_components
	backgroundColor: ""
	html: ""
	style:
		fontSize: "35px"
		fontWeight: "500"
		textAlign: "center"
		color: "#FC42A8"
artist.states.animationOptions = time: 0.2
artist.states.add
	intro: opacity: 0
	song: opacity: 1

player_controls = new Layer
	x: Align.center
	y: Align.bottom(-100)
	width: 620
	height: 38
	image: "images/player_controls.png"
	parent: song_screen_components
	
close_btn = new Layer
	width: 120
	height: 120
	image: "images/close_btn.png"
	parent: song_screen_components
	x: Align.left, y: Align.top

close_btn.on Events.TouchEnd, (e) ->
	e.stopPropagation()

prev_song_wrapper = new Layer
	width: 129, height: 145
	parent: song_screen_components
	backgroundColor: ""
	x: 146
	y: 1147
	
next_song_wrapper = new Layer
	width: 129, height: 145
	parent: song_screen_components
	backgroundColor: ""
	x: 475
	y: 1147

prev_song = new Layer
	width: 34
	height: 40
	image: "images/prev_song.png"
	parent: prev_song_wrapper
	y: Align.center, x: Align.center

next_song = new Layer
	width: 34
	height: 40
	image: "images/next_song.png"
	parent: next_song_wrapper
	y: Align.center, x: Align.center
	
progress = new Layer
	width: full_width, height: 10
	backgroundColor: "rgba(255, 255, 255, 0.4)"
	parent: song_screen
	x: Align.center
	
bar = new Layer
	parent: progress
	height: 10, width: 0
	x: Align.left
	opacity: 0.8
	backgroundColor: "FC42A8"

progress_proxy = new Layer 
	visible: false
	x: 0.01

progress_proxy.on "change:x", ->
	size = Utils.modulate(progress_proxy.x, [0, 100], [0, full_width])
	bar.width = size

progress_time = new Layer
	html: "123"
	backgroundColor: ""
	style:
		"font-family": "Roboto Mono"
		"font-size": "32px"
		"text-align": "right"
		"text-shadow": "1px 1px 0px rgba(0, 0, 0, 0.3)"
	x: 563, y: 37
	parent: song_screen
	width: 165, height: 44
	opacity: 0

progress_time.states.animationOptions =
	time: 0.3
progress_time.states.add
	show: opacity: 1
	hide: opacity: 0


# Audio Player Control
song_player = new AudioPlayer
	y: Align.bottom(full_height - 20)
	opacity: 0
	visible: false
	
song_player.showProgress = true
song_player.centerX()
song_player.controls.props =
	scale: 1.5

song_player.progressBar.props = 
	y: Align.bottom(-260)
	width: 600
	backgroundColor: "rgba(255, 255, 255, 0.4)"
	parent: song_screen_components

song_player.progressBar.knob.props =
	width: 7, height: 25

song_player.progressBar.centerX()
song_player.progressBar.fill.backgroundColor = "#FC42A8"

song_player.progressBar.visible = false

song_player.states.add
	show:
		y: Align.bottom(-20)
		opacity: 1
	hide:
		y: Align.bottom(full_height - 20)
		opacity: 0

song_player.states.animationOptions =
	time: 0.4
	curve: "ease-in-out"

# Play/Pause button control
pause = new Layer
	width: 140
	height: 140
	image: "images/pause.png"
	parent: song_screen_components
	y: 1147, x: 305
pause.states.animationOptions = 
	time: 0
pause.states.add
	show: y: 1147
	hide: y: 4000

pause.on Events.Tap, (e) ->
	e.stopPropagation()
	if video.player.paused
		video.player.play()
		song_player.player.play()
		this.image = "images/pause.png"
	else
		video.player.pause()
		song_player.player.pause()
		this.image = "images/play.png"

# Play/Pause event control
VIDEO_FOCUSED = false
CURRENT_TIME = 0
timerInterval = null

switchToVideo = ->
	song_screen_components.states.switch("focus_video")

	ANIMATION_PROGRESS = progress_proxy.x / 100
	# Restart the video and unmute
	if video.player.paused
		video.player.play()
		video.player.volume = 1
		video.player.muted = false
	
	if !PLAYING_INTRO
		video.player.currentTime = CURRENT_TIME
		TOTAL_TIME = video.player.duration
		progress_time.html = Math.floor(TOTAL_TIME - CURRENT_TIME)
		progress_time.states.switch("show")
		video_gradient_bot.states.switch("show")
		
		progress_proxy.animate
			properties: x: 100
			time: TOTAL_TIME * (1 - ANIMATION_PROGRESS)
			curve: "linear"
		
		startTimerInterval(TOTAL_TIME - CURRENT_TIME)

	# Pause the audio track
	song_player.player.pause()
	song_player.states.switch("hide")

	Utils.delay 0.001, ->
		VIDEO_FOCUSED = true
	
switchToAudio = ->
	song_screen_components.states.switch("show_control")
	
	if !PLAYING_INTRO
		video.player.volume = 0
		video.player.muted = true
		CURRENT_TIME = video.player.currentTime
		stopInterval()
	
	video_gradient_bot.states.switch("hide")
	progress_time.states.switch("hide")
	pause.states.switch("show")
	progress_proxy.animateStop()
	# Resume audio
	song_player.player.play()
	
	song_player.states.switch("show")		

	Utils.delay 0.001, ->
		VIDEO_FOCUSED = false
	

startTimerInterval = (start) ->
	timerInterval = Utils.interval 1, ->
		if start <= 0
			switchToAudio()
			progress_proxy.x = 0
		else
			progress_time.html = Math.floor(start--)

stopInterval = ->
	clearInterval(timerInterval)

# This event listener controls the song screen transition to video
song_screen.on Events.Tap, ->
	# If the video is already focused, simply return
	switchToVideo() unless VIDEO_FOCUSED

# This event listener controls the song screen transition back to the song
song_screen.on Events.Tap, ->
	# If the song is already playing, simply return
	switchToAudio() unless !VIDEO_FOCUSED

progress_proxy.on Events.AnimationEnd, ->
	switchToAudio()
	progress_proxy.x = 0

# Fade in audio so it's not an abrupt transition
song_screen_components.on "change:opacity", ->
	if !PLAYING_INTRO
		video.player.volume = Utils.modulate(this.opacity, [1, 0], [0, 1])
		song_player.player.volume = Utils.modulate(this.opacity, [1, 0], [1, 0])



###################
# Defining States #
###################
_hasPlayedIntro = false
PLAYING_INTRO = false
PLAYING = false
CURRENT_SONG_INDEX = -1
NUM_SONGS = media.length

# Functions to show and hide the song screen
# These functions do NOT control song playback, just toggle visiblity
show_play_screen = ->
	intro_popup.states.switch("hide")
	song_screen.states.switch("playing")
	song_player.opacity = 1
	song_player.states.switch("show")
	video.player.play()

hide_play_screen = ->
	song_screen.states.switch("hidden")
	song_player.opacity = 0
	song_player.states.switch("hide")
	if !PLAYING_INTRO
		video.player.pause()

song_screen.states.add
	hidden:
		y: full_height
		opacity: 0
	playing:
		y: Align.center
		opacity: 1

# Animate into the now playing screen
song_screen.states.animationOptions = 
	curve: "ease-in-out"
	time: 0.4

# Play the artist introduction
play_intro = ->
	if _hasPlayedIntro
		start_play(Utils.round(Utils.randomNumber(0, NUM_SONGS - 1)))
		return

	PLAYING_INTRO = true
	_hasPlayedIntro = true
	video.video = "media/intro.mp4"
	video.player.muted = false
	video.player.volume = 1
	
	title.states.switch("intro")
	artist.states.switch("intro")
	show_play_screen()

Events.wrap(video.player).on "ended", ->
	# If playing the intro, end the intro and move on the songs
	if PLAYING_INTRO
		PLAYING_INTRO = false
		VIDEO_FOCUSED = false
		# After the intro, play a random song
		song_screen_components.states.switch("show_control")
		pause.states.switch("show")
		song_player.states.switch("show")		
		start_play(0)

# START PLAYING A SONG
# index: the index of the song in the media array
start_play = (index) ->
	song_player.progressBar.visible = true
	PLAYING = true
	PLAYING_INTRO = false
	_hasPlayedIntro = true
	CURRENT_SONG_INDEX = index
	song = media[index]
	
	# Insert song data inside components
	title.states.switch("song")
	artist.states.switch("song")

	title.html = song.name
	artist.html = song.artist
	song_player.audio = song.url
	video.video = song.video
	video.player.loop = true
	video.player.muted = true
	video_comment.html = if song.comment then song.comment else "from Meghan Trainor"

	# Reset video tracking variables
	CURRENT_TIME = 0
	bar.width = 0
	progress_proxy.x = 0
	
	# Reset player images
	pause.image = "images/pause.png"

	show_play_screen()
	
	# Play the songs
	song_player.player.play()
	
	# Show the now playing bar after a slight delay; otherwise it would 
	# be visible before the animation of the play screen.
	Utils.delay 0.5, ->
		playing_bar.visible = true
		playing_bar_song.html = generatePlayingBarText(song.name, song.artist)
		song_scroll.contentInset = 
			bottom: 200

# Trigger the ENTER animation
play_btn.onClick ->
	play_intro()

# Add event listeners to each song
break_free.onClick ->
	start_play(3)
	
_no.onClick ->
	start_play(0)

bass.onClick ->
	start_play(2)
	
right_here.onClick ->
	start_play(1)

# Choose the next song when clicking next/prev
next_song_wrapper.on Events.Tap, (e) ->
	e.stopPropagation()
	start_play((CURRENT_SONG_INDEX + 1) % NUM_SONGS)
	
prev_song_wrapper.on Events.Tap, (e) ->
	e.stopPropagation()
	if PLAYING_INTRO
		return
	if CURRENT_SONG_INDEX == 0
		start_play(NUM_SONGS - 1)
	else
		start_play(CURRENT_SONG_INDEX - 1)
	
# Song screen video states
song_screen_components.states.add
	focus_video: opacity: 0
	show_control: opacity: 1

song_screen_components.states.animationOptions =
	curve: "ease-in-out"
	time: 0.4
	
# Exit the playing screen
close_btn.on Events.Tap, (e) ->
	e.stopPropagation()
	hide_play_screen()
