module(..., package.seeall);

function new(params)
	local human = display.newImage(params.image);
	human.type = "human";
	human.x = params.x;
	human.y = params.y;
	
	human.xScale = 0.5;
	human.yScale = 0.5;
	transition.to(human, { time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic });
	
	local physics_body = {};
	if (params.name == "weirdo") then
		physics_body = weirdo_body;
	elseif (params.name == "oliver") then
		physics_body = oliver_body;
	elseif (params.name == "nonoy") then
		physics_body = nonoy_body;
	end
	_physics.addBody(human, "dynamic", unpack(physics_body));
	
	local function onCollision( human, event )
		if (event.phase == "began" ) then
			if (event.other.type == "enemy") then
				local randomIndex = math.random(1, #_killed_sounds);
				audio.play(_killed_sounds[randomIndex]);
				human:removeSelf();
				human = nil;
			end
		end
	end
	
	human.collision = onCollision;
	
	-- local function startDrag( event )
		-- if event.phase == "began" then
			-- display.getCurrentStage():setFocus( event.target );
			-- event.target.isFocus = true;
			-- event.target.x0 = event.x - event.target.x;
			-- event.target.y0 = event.y - event.target.y;
			-- event.target.bodyType = "kinematic";
		-- elseif event.target.isFocus then
			-- if event.phase == "moved" then
				-- event.target.x = event.x - event.target.x0;
				-- event.target.y = event.y - event.target.y0;
			-- elseif event.phase == "ended" or event.phase == "cancelled" then
				-- display.getCurrentStage():setFocus( nil );
				-- event.target.isFocus = false;
				-- event.target.bodyType = "dynamic";
			-- end
		-- end
		-- return true;
	-- end
	
	local function removeJoint( event )
		if event.phase == "began" then
			event.target:removeSelf();
		end
		return true;
	end
	
	local function startDrag( event )
		local stage = display.getCurrentStage();
		if event.phase == "began" then
			stage:setFocus(event.target, event.id);
			event.target.tempJoint = _physics.newJoint("touch", event.target, event.x, event.y);
		elseif event.phase == "moved" then
			event.target.tempJoint:setTarget(event.x, event.y);
		elseif event.phase == "ended" then
			stage:setFocus(event.target, nil);
			event.target.tempJoint:removeSelf();
			--local line = display.newLine( event.target.x, event.target.y, event.x, event.y );
			--print("event.target.x : " .. event.target.x .. "  event.target.y : " .. event.target.y .. "  tempX: " .. tempX .. "   tempY : " .. tempY);
			--event.target.tempJoint:addEventListener( "touch", removeJoint );
		end
		return true;
	end
	
	human:addEventListener( "touch", startDrag )
	human:addEventListener("collision", human);
	
	return human;
end


weirdo_body = 
{
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   18, -23  ,  14.5, -51.5  ,  18.5, -49.5  ,  23, -43  ,  24, -30  ,  23.5, -24.5  ,  23, -21  ,  20.5, -18.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -29, -11  ,  -27, -13  ,  -26, -8  ,  -28.5, -8.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -19, 33  ,  10, 41  ,  10.9671173095703, 51.1605415642262  ,  -19.5, 50.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   23.5, -24.5  ,  24, -30  ,  28.5, -26.5  ,  29, -24  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   8, 39  ,  5, 34  ,  7.5, 34.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -24, 22  ,  -22, 19  ,  8, 39  ,  10, 41  ,  -19, 33  ,  -24, 28  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -26, -8  ,  -27, -13  ,  -26, -19  ,  -18.5, -46.5  ,  -4.5, -51.5  ,  -11.5, -2.5  ,  -20.5, -2.5  ,  -24.5, -4.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -11.5, -2.5  ,  -1.5, -2.5  ,  -2, -1  ,  -22, 19  ,  -20, 4  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   5, 34  ,  -22, 19  ,  -2, -1  ,  2.5, 2.5  ,  7, 16  ,  9, 27  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -18.5, -46.5  ,  -26, -19  ,  -30, -24  ,  -30, -39  ,  -24, -46  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -4.5, -51.5  ,  -18.5, -46.5  ,  -14.5, -49.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   14.5, -51.5  ,  16, -22  ,  10.5, -2.5  ,  -11.5, -2.5  ,  -4.5, -51.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   10.5, -2.5  ,  16, -22  ,  15, -6  ,  13, -4  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   16, -22  ,  14.5, -51.5  ,  18, -23  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   8, 39  ,  -22, 19  ,  5, 34  }
	}
}
	
oliver_body =
{
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -21, 32  ,  -18, 27  ,  -18, 37  ,  -21, 36  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   22, 26  ,  17.5, 28.5  ,  22, 15  ,  25, 20  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   20.5, 49.5  ,  1.5, 49.5  ,  16, 38  ,  25.5, 42.5  ,  25, 47  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   16, 38  ,  1.5, 49.5  ,  17.5, 28.5  ,  19, 34  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -17, -7  ,  -20, 16  ,  -23, 13  ,  -26, 4  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -20, 16  ,  -1.5, 46.5  ,  -18, 27  ,  -22, 21  ,  -22, 18  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -20.5, 40.5  ,  -4.5, 49.5  ,  -22.5, 49.5  ,  -27, 45  ,  -27, 42  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   25, 11  ,  22, 15  ,  11.5, -10.5  ,  20.5, -5.5  ,  26, 2  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   19, -41  ,  11.5, -10.5  ,  -20, -15  ,  -21, -37  ,  -17, -44  ,  -5.5, -50.5  ,  5.5, -50.5  ,  13.5, -47.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -18, 37  ,  -4.5, 49.5  ,  -20.5, 40.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -18, 27  ,  -1.5, 46.5  ,  -4.5, 49.5  ,  -18, 37  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   17.5, 28.5  ,  1.5, 49.5  ,  -1.5, 46.5  ,  -17, -7  ,  -17, -11  ,  11.5, -10.5  ,  22, 15  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -17, -7  ,  -1.5, 46.5  ,  -20, 16  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   11.5, -10.5  ,  19, -41  ,  21, -36  ,  21, -21  ,  19, -17  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   11.5, -10.5  ,  -17, -11  ,  -20, -15  }
	}
}
nonoy_body =
{
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -24, 6  ,  -13.5, 6.5  ,  -19.5, 9.5  ,  -23.5, 9.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -22, -10  ,  -23, -7  ,  -27, -3  ,  -31, -7  ,  -31, -11  ,  -27.5, -13.5  ,  -23.5, -13.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   26, -35  ,  28, -28  ,  24.5, -19.5  ,  22, -28  ,  23, -35  ,  25.5, -36.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -16.5, 48.5  ,  -24.5, 48.5  ,  -25, 47  ,  -20.5, 41.5  ,  -9, 36  ,  -9, 47  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   24.5, -19.5  ,  28, -28  ,  30, -24  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   13, -22  ,  9.5, -18.5  ,  -17.5, -12.5  ,  -22, -21  ,  -20.5, -29.5  ,  8, -30  ,  12.5, -27.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   21, 42  ,  11, 46  ,  7.5, 45.5  ,  7, 44  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   30, -34  ,  28, -28  ,  26, -35  ,  29.5, -35.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -20.5, 41.5  ,  -25, 47  ,  -25, 44  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   24.5, -19.5  ,  20, -21  ,  19, -24  ,  22, -28  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   9, -42  ,  8, -30  ,  -20.5, -29.5  ,  -17.5, -47.5  ,  -8.5, -50.5  ,  4.5, -49.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   24, 48  ,  21.5, 49.5  ,  15.5, 49.5  ,  11, 46  ,  21, 42  ,  23.5, 42.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   22, -11  ,  18, -7  ,  7.5, -5.5  ,  13, -14  ,  20, -21  ,  24.5, -19.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -17.5, -47.5  ,  -20.5, -29.5  ,  -23, -43  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   8.5, 17.5  ,  -8, -5  ,  4, -6  ,  10, 7  ,  12, 17  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -27, -3  ,  -23, -7  ,  -17.5, 0.5  ,  -13.5, 6.5  ,  -24, 6  ,  -27, 2  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -30, -24  ,  -20.5, -29.5  ,  -22, -21  ,  -29.5, -21.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   8, -11  ,  -15, -12  ,  -17.5, -12.5  ,  9.5, -18.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   17, -3  ,  11, 3  ,  7.5, -5.5  ,  18, -7  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   11, 3  ,  10, 7  ,  4, -6  ,  7.5, -5.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5,
		shape = {   -18, 35  ,  -10, 24  ,  -7.5, 32.5  ,  -9, 36  ,  -20.5, 41.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -10, 24  ,  1.5, 24.5  ,  -7.5, 32.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -11, 21  ,  -9, 10  ,  1.5, 24.5  ,  -10, 24  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -11.5, -0.5  ,  -9, 10  ,  -13.5, 6.5  ,  -17.5, 0.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   -8, -5  ,  8.5, 17.5  ,  16, 31  ,  10, 32  ,  1.5, 24.5  ,  -9, 10  ,  -11.5, -0.5  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   21, 42  ,  10.5, 43.5  ,  11, 42  ,  16, 31  ,  22, 40  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   16, 31  ,  8.5, 17.5  ,  15, 26  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   8, -11  ,  4, -6  ,  -8, -5  ,  -15, -12  }
	}  ,
	{
		density=1, friction=0.1, bounce = 0.5, 
		shape = {   16, 31  ,  11, 42  ,  10, 32  }
	} 
}