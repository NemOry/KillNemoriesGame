module(..., package.seeall);
_physics.start();

audio.play(_sound_horror, {loops = -1});
audio.play(_sound_laugh, {loops = -1});
audio.play(_sound_thunder, {loops = -1});

local current_level = "level2";
local next_level = "level3";

function new()
	local group = display.newGroup();
	local humanGroup = display.newGroup();
	local objectsGroup = display.newGroup();
	
	local background = setBackground("images/game_bg_cyan.jpg");
	local dlg_paused = _dialog.new({type = "pause_dialog", mainGroup = group, current_level = current_level});
	local dlg_game_finished = _dialog.new({type = "game_finished_dialog", nextLevel = next_level, mainGroup = group});
	local btn_pause = _button.new({x = 50, y = 50, image = "images/btn_pause.png", type = "pause", dialog = dlg_paused});
	local btn_reload = _button.new({x = 100, y = 50, image = "images/btn_reload.png", type = "reload", mainGroup = group, current_level = current_level});
	
	local elesi = _elesi.new({x = xCenter, y = yCenter + 150});
	local bubble = _bubble.new({x = xCenter + 300, y = _H - 100});
	
	objectsGroup:insert(elesi);
	objectsGroup:insert(bubble);
	
	local human_oliver = _human.new({name = "oliver", image = "images/oliver.png", x = xCenter + 200, y = _H - 100});
	
	humanGroup:insert(human_oliver);
	
	group:insert(background);
	group:insert(btn_pause);
	group:insert(btn_reload);
	group:insert(objectsGroup);
	group:insert(humanGroup);
	group:insert(dlg_paused);
	group:insert(dlg_game_finished);

	local function check()
		if (humanGroup.numChildren == 0) then
			elesi.stop();
			Runtime:removeEventListener("enterFrame", check);
			dlg_game_finished.show();
		end
	end

	Runtime:addEventListener("enterFrame", check);
	return group;
end