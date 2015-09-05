module(..., package.seeall);

function new(params)
	local mushroom = display.newImage("images/mushroom.png");
	mushroom.type = "mushroom";
	mushroom.x = params.x;
	mushroom.y = params.y;
	
	_physics.addBody(mushroom, "static", { density=0.2, friction=0.1, bounce=0.3, radius = mushroom.width / 2 });
	
	local function onCollision(self, event)
		if (event.phase == "began" and self.name == "circle") then
			local forcex = event.other.x - self.x;
			local forcey = event.other.y - self.y;
			print("x: " .. forcex .. ", y: " .. forcey);
			event.other:applyForce(forcex, forcey, self.x, self.y);
		elseif (event.phase == "ended" and self.name == "circle") then
			self:removeSelf();
		end
	end
	
	function mushroom:collision(event)
		if (event.other.type ~= "platform") then
			local function addCircle()
				local circle = display.newCircle(mushroom.x, mushroom.y, 150);
				circle.name = "circle";
				physics.addBody(circle, "static", {isSensor = true, radius = circle.width / 2});
				circle.collision = onCollision;
				circle:addEventListener("collision", circle);
			end
			timer.performWithDelay(1, addCircle, 1);
		end
	end
	
	mushroom:addEventListener("collision", mushroom);
	
	return mushroom;
end