module(..., package.seeall);

function new(params)
	local mushroom = display.newImage("images/mushroom.png");
	mushroom.type = "mushroom";
	mushroom.x = params.x;
	mushroom.y = params.y;
	
	_physics.addBody(mushroom, "static", unpack(mushroom_body));
	
	function mushroom:collision(event)
		if (event.phase == "began") then
			if (event.other.type ~= "platform") then
				pop(self);
			end
		end
	end
	
	mushroom:addEventListener("collision", mushroom);
	return mushroom;
end

mushroom_body = 
{
	{
		density = 0, friction = 0, bounce = 2, 
		shape = {   49.6284561157227, 64.1857707500458  ,  -48, 64  ,  60, 33  ,  60.3142242431641, 57.0573124885559  }
	}  ,
	{
		density = 0, friction = 0, bounce = 2, 
		shape = {   -75.5, 19.5  ,  -75.5, -10.5  ,  -61.3142290115356, -40.2667999267578  ,  -4, -65  ,  45, -48  ,  63, -29  ,  -60.5, 31.5  ,  -68, 31  }
	}  ,
	{
		density = 0, friction = 0, bounce = 2, 
		shape = {   60, 33  ,  63, -29  ,  75.2667999267578, -1.15217590332031  ,  74.5, 28.5  ,  69, 33  }
	}  ,
	{
		density = 0, friction = 0, bounce = 2, 
		shape = {   -48, 64  ,  -58.5237159729004, 51.381422996521  ,  -60.5, 31.5  ,  63, -29  ,  60, 33  }
	}  ,
	{
		density = 0, friction = 0, bounce = 2, 
		shape = {   45, -48  ,  -4, -65  ,  21.7430801391602, -63.4189758300781  }
	}
}