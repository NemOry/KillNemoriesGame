module(..., package.seeall);

function new(params)
	local bomb = display.newImage("images/bomb.png");
	bomb.type = "bomb";
	bomb.x = params.x;
	bomb.y = params.y;
	
	bomb.xScale = 0.5;
	bomb.yScale = 0.5;
	transition.to(bomb, { time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic });
	
	_physics.addBody(bomb, "dynamic", { density = 3.0, friction=0.5, bounce=0.3 });
	
	local function onCollision( self, event )
		if (event.phase == "ended" ) then
			if (event.other.type ~= "platform") then
				local function blast()
					local forcex = event.other.x - self.x;
					local forcey = event.other.y - self.y;
					if(forcex < 0) then
						forcex = 0-(80 + forcex)-12;
					else
						forcex = 80 - forcex+12;
					end
					event.other:applyForce(forcex, forcey, self.x, self.y );
					if(math.abs(forcex) > 60 or math.abs(forcey) > 60) then
						local explosion = display.newImage("images/explosion.png", event.other.x, event.other.y );
						--event.other:removeSelf();
						local function removeExplosion(event )
							explosion:removeSelf();
						end
						timer.performWithDelay(50,  removeExplosion);
					end
		
					audio.play(owa1);
					self:removeSelf();
				end
				timer.performWithDelay(2000, blast);
			end
		end
	end
	
	bomb.collision = onCollision;
	bomb:addEventListener("collision", bomb);
	
	return bomb;
end