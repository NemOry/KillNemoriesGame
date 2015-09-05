---------------------- GLOBAL CLASS MODULES ---------------------- 
_physics 	= require("physics");
_physics.setDrawMode("hybrid");

_director 	= require("director");
_easingx 	= require("easingx");

_dialog 	= require("dialog");
_pungkoy 	= require("pungkoy");
_mushroom 	= require("mushroom");
_stone 		= require("stone");
_pitoy 		= require("pitoy");
_punso 		= require("punso");
_human 		= require("human");
_karito 	= require("karito");
_bubble 	= require("bubble");
_crate 		= require("crate");
_platform 	= require("platform");
_virus 		= require("virus");
_time_bomb 	= require("time_bomb");
_chain 		= require("chain");
_elesi 		= require("elesi");
_button 	= require("button");

---------------------- GLOBAL VARIABLES AND OBJECTS ---------------------- 
_H			= display.contentHeight;
_W			= display.contentWidth;
xCenter 	= _W / 2;
yCenter 	= _H / 2;

---------------------- SOUND OBJECTS ----------------------
_sound_horror		= audio.loadStream("sounds/horror.mp3");
_sound_laugh		= audio.loadStream("sounds/laugh.mp3");
_sound_thunder		= audio.loadStream("sounds/thunder.mp3");
_sound_cricket		= audio.loadStream("sounds/cricket.mp3");

_sound_pop			= audio.loadSound("sounds/pop.mp3");
_sound_explosion	= audio.loadSound("sounds/explosion.mp3");
_sound_slice		= audio.loadSound("sounds/slice.mp3");

_sound_owa1		= audio.loadSound("sounds/owa1.wav");
_sound_owa2		= audio.loadSound("sounds/owa2.wav");
_killed_sounds = {_sound_owa1, _sound_owa2};

function setBackground(image)
	local group = display.newGroup();
	local background = display.newImage(image);
	background.x = xCenter;
	background.y = yCenter;
	
	local grass = display.newImage("images/grass.png");
	grass.x = xCenter;
	grass.y = _H - 100;
	
	local ground = display.newImage("images/ground.png");
	ground.type = "platform";
	ground.x = xCenter;
	ground.y = _H - 20;

	_physics.addBody(ground, "static", {friction=0.1});
	
	group:insert(background);
	group:insert(grass);
	group:insert(ground);
	return group;
end

function pop(object)
	object.xScale = 0.5;
	object.yScale = 0.5;
	transition.to(object, {time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic});
end