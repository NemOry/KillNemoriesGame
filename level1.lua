module(..., package.seeall);
_physics.start();

-- audio.play(_sound_horror, {loops = -1});
-- audio.play(_sound_laugh, {loops = -1});
-- audio.play(_sound_thunder, {loops = -1});
-- audio.play(_sound_cricket, {loops = -1});

local current_level = "level1";
local next_level = "level2";

function new()
	------------------------ DISPLAY GROUPS ------------------------------
	local parentGroup = display.newGroup();
	local humanGroup = display.newGroup();
	local objectsGroup = display.newGroup();
	local background = setBackground("images/game_bg_cyan.jpg");

	------------------------ BUTTON LISTENERS ------------------------------
	local onClickListener = function (event)
		if (event.phase == "ended") then
			local button = event.target;
			pop(button);
			if(button.type == "pause") then
				print("pause");
				dlg_paused.show();
				--_physics.pause();
			elseif(button.type == "resume") then
				print("resume");
				_physics.start();
			elseif(button.type == "next") then
				print("next");
				stopElesi();
				director:changeScene(next_level);
			elseif(button.type == "reload") then
				print("reload");
				stopElesi();
				director:changeScene(current_level);
			end
		end
		return true;
	end
	
	------------------------ DAILOG ------------------------------
	dlg_game_finished = _dialog.new("game_finished");
	dlg_game_finished.btn_left:addEventListener("touch", onClickListener);
	dlg_game_finished.btn_right:addEventListener("touch", onClickListener);
	
	------------------------ DAILOG ------------------------------
	dlg_paused = _dialog.new("paused");
	dlg_paused.btn_left:addEventListener("touch", onClickListener);
	dlg_paused.btn_right:addEventListener("touch", onClickListener);
	
	------------------------ BUTTONS ------------------------------
	local btn_pause = _button.new({type = "pause", image = "images/btn_pause.png", x = 40, y = 50});
	local btn_reload = _button.new({type = "reload", image = "images/btn_reload.png", x = 100, y = 50});
	
	btn_pause:addEventListener("touch", onClickListener);
	btn_reload:addEventListener("touch", onClickListener);

	------------------------ ENVIRONMENT OBJECTS ------------------------------
	local crate = _crate.new({x = 50, y = 90, bodyType = "dynamic"}) ;
	-- for index1 = 1, 2 do
		-- for index2 = 1, 5 do
			-- _crate.new({x = 200 + (index2 * 60), y = (_H - 100) - (index1 * 60), bodyType = "dynamic"}) ;
		-- end
	-- end
	
	--local mushroom = _mushroom.new({x = xCenter, y = _H-100});
	local pungkoy = _pungkoy.new({x = xCenter, y = 200});
	-- local elesi = _elesi.new({x = xCenter, y = yCenter + 150});
	
	-- local function rotateElesi()
		-- elesi.rotation = elesi.rotation + 4;
	-- end
	
	-- function stopElesi()
		-- Runtime:removeEventListener("enterFrame", rotateElesi);
	-- end

	-- Runtime:addEventListener("enterFrame", rotateElesi);
	
	--local punso = _punso.new({x = 200, y = _H - 100});
	--local karito = _karito.new({x = xCenter, y = 60});
	--local stone = _stone.new({x = 100, y = _H - 200});
	--local pitoy = _pitoy.new({x = 200, y = _H - 150});
	local time_bomb = _time_bomb.new({x = 200, y = _H - 100});
	--local bubble = _bubble.new({x = 200, y = _H - 100});

	objectsGroup:insert(crate);
	--objectsGroup:insert(elesi);
	
	local human_weirdo = _human.new({name = "weirdo", image = "images/weirdo.png", x = 140, y = yCenter - crate.height});

	humanGroup:insert(human_weirdo);
	
	parentGroup:insert(background);
	parentGroup:insert(objectsGroup);
	parentGroup:insert(humanGroup);
	parentGroup:insert(dlg_paused);

	local function check()
		if (humanGroup.numChildren == 0) then
			stopElesi();
			Runtime:removeEventListener("enterFrame", check);
			dlg_game_finished.show();
		end
	end

	Runtime:addEventListener("enterFrame", check);
	return parentGroup;
end