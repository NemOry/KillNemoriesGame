module(..., package.seeall);

function new(params)
	local bubble = display.newImage("images/bubble.png");
	bubble.type = "bubble";
	bubble.x = params.x;
	bubble.y = params.y;
	
	bubble.xScale = 0.5;
	bubble.yScale = 0.5;
	transition.to(bubble, {time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic});
	
	_physics.addBody(bubble, "dynamic", {density=0.2, friction=0.1, bounce=0.3, radius = bubble.height/2});
	
	local function onCollision(self, event)
		if (event.phase == "began" and self.name == "circle") then
			local forcex = event.other.x - self.x;
			local forcey = event.other.y - self.y - 20;
			if(forcex < 0) then
				forcex = 0-(700 + forcex) - 12;
			else
				forcex = 700 - forcex + 12;
			end
			event.other:applyForce(forcex, forcey, self.x, self.y);
			self:removeSelf();
		end
	end
	
	function bubble:touch(event)
		if (event.phase == "began") then
			audio.play(_sound_pop);
			local circle = display.newCircle(bubble.x, bubble.y, 150);
			bubble:removeSelf();
			physics.addBody(circle, "static", {isSensor = true});
			circle.name = "circle";
			circle.collision = onCollision;
			circle:addEventListener("collision", circle);
			
			local function removeCircle()
				circle:removeSelf();
			end
			
			timer.performWithDelay(1, removeCircle, 1);
		end
	end
	bubble:addEventListener("touch", bubble);
	
	return bubble;
end