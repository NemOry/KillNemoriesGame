module(..., package.seeall);

function new(params)
	local bomb = display.newImage("images/bomb.png");
	bomb.type = "bomb";
	bomb.x = params.x;
	bomb.y = params.y;
	
	bomb.xScale = 0.5;
	bomb.yScale = 0.5;
	transition.to(bomb, { time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic });
	
	_physics.addBody(bomb, "dynamic", { density=0.2, friction=0.1, bounce=0.3, radius = bomb.height/2 });
	
	local function onCollision(self, event)
		print(event.other.type);
		if (event.phase == "began" and self.name == "circle") then
			self.collision = nil;
			local forcex = event.other.x - self.x;
			local forcey = event.other.y - self.y;
			if(forcex < 0) then
				forcex = 0-(80 + forcex) - 12;
			else
				forcex = 80 - forcex + 12;
			end
			event.other:applyForce(forcex, forcey, self.x, self.y);
		end
	end
	
	function bomb:collision(event)
		if (event.other.type ~= "platform") then
			bomb:removeEventListener("collision", bomb);
			local function addCircle()
				local circle = display.newCircle(bomb.x, bomb.y, 100);
				circle:setFillColor(0,0,0, 0);
				circle.name = "circle";
				physics.addBody(circle, "static");
				circle.collision = onCollision;
				circle:addEventListener("collision", circle);
				bomb:removeSelf();
				circle:removeSelf();
				audio.play(_sound_pop);
			end
			timer.performWithDelay(2000, addCircle, 1);
		end
	end
	
	bomb:addEventListener("collision", bomb);
	
	return bomb;
end