Framer.Info =
	title: "Prototype 1"
	author: "Eric Liang"
	twitter: "hiEricLiang"
	description: "First prototype for artist channel, tested on 7/20/16 soundcheck."
	
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.disable()

{AudioPlayer} = require "audio"

full_width = Framer.Device.screen.width
full_height = Framer.Device.screen.height
Canvas.backgroundColor = "#F7F7F7"

generatePlayingBarText = (song, artist) ->
	return "<span >#{song} &middot; </span><span style='color: #BBB'>#{artist}</span>"


# Initial Page

profile_scroll = new ScrollComponent
	width: full_width, height: full_height
	backgroundColor: ""
	scrollHorizontal: false

profile = new Layer
	width: full_width
	height: 2966
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
	y: 752
	width: 750
	height: 306
	backgroundColor: "rgba(52, 152, 219,0.3)"
	borderColor: "rgba(52, 152, 219,1.0)"
	borderWidth: 3, borderRadius: 7
	opacity: 0
	parent: profile_scroll.content

playlist_trigger.onClick ->
	song_scroll.states.switch("show")


# Create Song Scroll Component
song_scroll = new ScrollComponent
	backgroundColor: "#181818"
	x: full_width
	y: Align.center
	scrollHorizontal: false
	width: full_width
	height: full_height
	contentInset: 
		bottom: 100
		
Screen.on Events.EdgeSwipeLeftStart, ->
	song_scroll.scrollVertical = false
	song_scroll.states.switch("hide")
	
Screen.on Events.EdgeSwipeLeftEnd, ->
	song_scroll.scrollVertical = true

song_scroll.states.animationOptions = 
	time: 0.3
	curve: "ease-in-out"
	
song_scroll.states.add
	show: x: Align.center
	hide: x: full_width

grande_pic = new Layer
	width: 750
	height: 1022
	image: "images/grande_pic.png"
	parent: song_scroll.content

alpha_gradient = new Layer
	width: full_width, height: 1038
	parent: song_scroll.content
	y: Align.top, x: Align.center
	
alpha_gradient.style.background = "-webkit-linear-gradient(top, rgba(0,0,0,0) 0%,rgba(24,24,24,1) 100%)"

play_btn = new Layer
	x: Align.center
	y: 926
	width: 280
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
	x: Align.center, y: 726
	backgroundColor: ""
	html: "Ariana Grande"
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
	y: 579
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

break_free = new Layer
	width: 740
	image: "images/break free.png"
	parent: song_scroll.content
	y: 1058
	x: 10

run_away = new Layer
	width: 712
	image: "images/run away.png"
	parent: song_scroll.content
	y: 1661
	x: 38

problem = new Layer
	width: 750
	image: "images/problem.png"
	parent: song_scroll.content
	y: 1261

the_way = new Layer
	width: 714
	image: "images/the way.png"
	parent: song_scroll.content
	y: 1461
	x: 36

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
	html: generatePlayingBarText("Thriller", "Michael Jackson")
	backgroundColor: ""
	width: 500
	x: 90, y: 14

playing_bar.style.fontSize = "26px"
playing_bar.style.fontWeight = "400"
playing_bar.style.color = "#FC42A8"

# Song Screen layers
song_screen = new Layer
	opacity: 0
	x: Align.center
	y: full_height
	width: full_width
	height: full_height
	backgroundColor: "#181818"

khaled = new VideoLayer
	x: Align.center
	y: Align.center
	scale: 1.88
	width: 1280
	height: 720
	parent: song_screen

khaled.player.loop = true
khaled.player.volume = 0
khaled.player.muted = true

song_screen_components = new Layer
	width: full_width
	height: full_height
	backgroundColor: ""
	parent: song_screen

gradient_bg = new Layer
	width: full_width
	height: full_height
	image: "images/gradient_bg.png"
	parent: song_screen_components

artist_img = new Layer
	width: 122, height: 122
	image: "images/artist_img.png"
	parent: song_screen_components
	x: Align.center, y: 31

instruction_prompt = new Layer
	html: "Tap anywhere to play video"
	backgroundColor: "rgba(255, 255, 255, 0.8)"
	color: "black"
	parent: song_screen_components
	x: 206
	y: 266
	
instruction_prompt.style = 
	"width": "auto"
	"height": "auto"
	"border-radius": "8px"
	"font-size": "24px"
	"font-weight": "600"
	"display": "inline-block"
	"padding": "8px 15px"

on_air = new Layer
	x: Align.center
	y: 200
	width: full_width
	height: 34
	opacity: 1
	html: "Ariana Grande"
	parent: song_screen
	backgroundColor: ""

on_air.style.fontSize = "43px"
on_air.style.fontWeight = "400"
on_air.style.textAlign = "center"
on_air.style.textShadow = "1px 1px 0px black"
	
title = new Layer
	x: Align.center
	y: Align.bottom(-350)
	height: 122, width: full_width
	parent: song_screen_components
	backgroundColor: ""
	html: "Song Name Here"
	
title.style.fontSize = "60px"
title.style.fontWeight = "700"
title.style.textAlign = "center"
title.style.lineHeight = "1.3"
	
artist = new Layer
	x: Align.center
	y: Align.bottom(-250)
	height: 122, width: full_width
	parent: song_screen_components
	backgroundColor: ""
	html: "Artist Here"

artist.style.fontSize = "40px"
artist.style.fontWeight = "500"
artist.style.textAlign = "center"
artist.style.color = "#FC42A8"

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
	width: full_width, height: 13
	backgroundColor: "rgba(255, 255, 255, 0.4)"
	parent: song_screen
	x: Align.center
	
bar = new Layer
	parent: progress
	height: 13, width: 0
	x: Align.left
	opacity: 0.8
	backgroundColor: "FC42A8"

progress_proxy = new Layer 
	visible: false
	x: 0.01

progress_proxy.on "change:x", ->
	size = Utils.modulate(progress_proxy.x, [0, 100], [0, full_width])
	bar.width = size


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

song_player.states.add
	show:
		y: Align.bottom(-20)
	hide:
		y: Align.bottom(full_height - 20)

song_player.states.animationOptions =
	time: 0.4
	curve: "ease-in-out"
	
pause = new Layer
	width: 140
	height: 140
	image: "images/pause.png"
	parent: song_screen_components
	y: 1147
	x: 305
pause.states.animationOptions = 
	time: 0
pause.states.add
	show: y: 1147
	hide: y: 4000

pause.on Events.Tap, (e) ->
	e.stopPropagation()
	if khaled.player.paused
		khaled.player.play()
		song_player.player.play()
		this.image = "images/pause.png"
	else
		khaled.player.pause()
		song_player.player.pause()
		this.image = "images/play.png"

# Play/Pause event control
PRESSED = false
should_hide = true
current_time = -1
total_time = 1

song_screen.on Events.Tap, ->
	if PRESSED
		return
	song_screen_components.states.switch("focus_video")
	
	total_time = khaled.player.duration
	ANIMATION_PROGRESS = progress_proxy.x / 100
	# Restart the video and unmute
	khaled.player.play()
	khaled.player.volume = 1
	khaled.player.muted = false
	khaled.player.currentTime = current_time - 1
	
	progress_proxy.animate
		properties: x: 100
		time: total_time * (1 - ANIMATION_PROGRESS)
		curve: "linear"
		
	# Pause the audio track
	song_player.player.pause()
	song_player.animate
		properties:
			opacity: 0
		time: 0.4
		curve: "ease-in-out"

	on_air.animate
		properties:
			y: 50
		time: 0.2
		curve: "ease-in-out"
		
	Utils.delay 0.4, ->
		if should_hide
			pause.states.switch("hide")
	Utils.delay 0.001, ->
		PRESSED = true
		
# Fade in audio so it's not an abrupt transition
song_screen_components.on "change:opacity", ->
	khaled.player.volume = Utils.modulate(this.opacity, [1, 0], [0, 1])
	song_player.player.volume = Utils.modulate(this.opacity, [1, 0], [1, 0])

song_screen.on Events.Tap, ->
	if !PRESSED
		return
	song_screen_components.states.switch("show_control")
	khaled.player.volume = 0
	khaled.player.muted = true
	current_time = khaled.player.currentTime
	pause.states.switch("show")
	should_hide = false
	Utils.delay 0.4, ->
		should_hide = true
		
	progress_proxy.animateStop()
	# Resume audio
	song_player.player.play()
	
	song_player.animate
		properties:
			opacity: 1
		time: 0.4
		curve: "ease-in-out"
		
	on_air.animate
		properties:
			y: 200
		time: 0.2
		curve: "ease-in-out"

	Utils.delay 0.001, ->
		PRESSED = false
	ALREADY_REACTED = false

###################
# Defining States #
###################
PLAYING = false
CURRENT_SONG_INDEX = -1
NUM_SONGS = 4

media = [{ 
		id: "way"
		name: "The Way"
		artist: "Ariana Grande (feat. Mac Miller)"
		url: "media/the_way.mp3"
		video: "media/japan.mp4"
	}, {
		id: "problem"
		name: "Problem"
		artist: "Ariana Grande, Iggy Azalea"
		url: "media/problem.mp3"
		video: "media/problem.mp4"
	}, {
		id: "runaway"
		name: "Run Away With Me"
		artist: "Carly Rae Jepsen"
		url: "media/run_away_with_me.mp3"
		video: "media/nails.mp4"
	}, {
		id: "breakfree"
		name: "Break Free"
		artist: "Ariana Grande feat. Zedd"
		url: "media/break_free.mp3"
		video: "media/break_free.mp4"
	}
]

show_play_screen = ->
	song_screen.states.switch("playing")
	song_player.opacity = 1
	song_player.states.switch("show")
	khaled.player.play()

hide_play_screen = ->
	song_screen.states.switch("hidden")
	song_player.opacity = 0
	song_player.states.switch("hide")
	khaled.player.pause()

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

start_play = (index) ->
	# Insert song data
	pause.image = "images/pause.png"
	CURRENT_SONG_INDEX = index
	song = media[index]
	PLAYING = true
	song_player.audio = song.url
	title.html = song.name
	artist.html = song.artist
	khaled.video = song.video
	total_time = khaled.video.duration
	current_time = 0
	bar.width = 0
	progress_proxy.x = 0

	show_play_screen()
	song_player.opacity = 1
	song_player.player.play()
	
	Utils.delay 0.5, ->
		playing_bar.visible = true
		playing_bar_song.html = generatePlayingBarText(song.name, song.artist)
		song_scroll.contentInset = 
			bottom: 200

playing_bar.on Events.Tap, ->
	show_play_screen()

# Trigger the ENTER animation
play_btn.onClick ->
	start_play(1)

break_free.onClick ->
	start_play(3)
	
the_way.onClick ->
	start_play(0)

run_away.onClick ->
	start_play(2)
	
problem.onClick ->
	start_play(1)

next_song_wrapper.on Events.Tap, (e) ->
	e.stopPropagation()
	start_play((CURRENT_SONG_INDEX + 1) % NUM_SONGS)
	
prev_song_wrapper.on Events.Tap, (e) ->
	e.stopPropagation()
	if CURRENT_SONG_INDEX == 0
		start_play(NUM_SONGS - 1)
	else
		start_play(CURRENT_SONG_INDEX - 1)
	
# Song screen video states
song_screen_components.states.add
	focus_video:
		opacity: 0
	show_control:
		opacity: 1

song_screen_components.states.animationOptions =
	curve: "ease-in-out"
	time: 0.5
	
# Exit the playing screen
close_btn.on Events.Tap, (e) ->
	hide_play_screen()
	e.stopPropagation()

