module(..., package.seeall);
function new()
	local group = display.newGroup();
	
	local background = display.newImage("images/game_bg_cyan.jpg");
	background.x = xCenter;
	background.y = yCenter;
	
	local title = display.newImage("images/title.png");
	title.x = xCenter;
	title.y = 200;
	
	local witch1 = display.newImage("images/witch1.png");
	witch1.x = xCenter - 350;
	witch1.y = 400;
	
	local witch2 = display.newImage("images/witch2.png");
	witch2.x = xCenter + 350;
	witch2.y = 400;
	
	local play = display.newImage("images/btn_menu_play.png");
	play.x = xCenter;
	play.y = yCenter + 100;
	play:scale(1.5, 1.5);
	play.scene = "level1";
	
	pop(play);
	
	-- local about = display.newImage("images/btn_about.png");
	-- about.x = xCenter;
	-- about.y = yCenter + 50;
	-- about:scale(1.5, 1.5);
	-- about.scene = "about";
	
	function changeScene(event)
		if (event.phase == "ended") then
			director:changeScene(event.target.scene);
		end
	end
	
	group:insert(background);
	group:insert(title);
	group:insert(play);
	-- group:insert(about);
	
	play:addEventListener("touch", changeScene);
	-- about:addEventListener("touch", changeScene);
	
	return group;
end