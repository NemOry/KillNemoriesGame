module(..., package.seeall);

function new(params)
	local bomb = display.newImage("images/bomb.png");
	bomb.type = "bomb";
	bomb.x = params.x;
	bomb.y = params.y;

	_physics.addBody(bomb, "dynamic", { density=0.2, friction=0.1, bounce=0.3, radius = bomb.width / 2 });
	
	local function onCollision(self, event)
		if (event.phase == "began" and self.name == "circle") then
			local forcex = event.other.x - self.x;
			local forcey = event.other.y - self.y-50;
			event.other:applyForce(forcex, forcey, self.x, self.y);
		end
	end
	
	function bomb:collision(event)
		if (event.other.type ~= "platform") then
			bomb:removeEventListener("collision", bomb);
			local function addCircle()
				local circle = display.newCircle(bomb.x, bomb.y, 150);
				bomb:removeSelf();
				circle.name = "circle";
				physics.addBody(circle, "static", {isSensor = true, radius = circle.width / 2});
				circle.collision = onCollision;
				circle:addEventListener("collision", circle);
				local function removeCircle()
					circle:removeSelf();
				end
				timer.performWithDelay(10, removeCircle, 1);
			end
			timer.performWithDelay(2000, addCircle, 1);
		end
	end
	
	bomb:addEventListener("collision", bomb);
	
	return bomb;
end