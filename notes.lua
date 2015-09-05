
-------------------- CHAIN ---------------------- 
local beam = display.newImage( "images/beam_long.png" );

local myJoints 	= {}
local link 		= {}
	
for i = 1,2 do
	for j = 1,17 do
		link[j] = display.newImage("images/link.png" );
		link[j].x = 121 + (i*34);
		link[j].y = 55 + (j*17);
		physics.addBody(link[j], { density=2.0, friction=0, bounce=0 } );
		
		if (j > 1) then
			prevLink = link[j-1]; -- each link is joined with the one above it
		else
			prevLink = beam; -- top link is joined to overhanging beam
		end
		myJoints[#myJoints + 1] = physics.newJoint("pivot", prevLink, link[j], 121 + (i*34), 46 + (j*17) );
	end
end

local function onLocalCollision(self, event)
	if (event.phase == "began" and self.name == "circle" ) then
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
			event.other:removeSelf();
			local function removeExplosion(event )
				explosion:removeSelf();
			end
			timer.performWithDelay(50,  removeExplosion);
		end
	end
end

local function setBomb (event)
	if(event.phase == "began") then
		local bomb = display.newImage("images/bomb.png", event.x,event.y );
		physics.addBody(bomb, { density=0.2, friction=0.1, bounce=0.5 });
		
		local circle = "";
		local explosion = "";
		local function blast(event)
			media.playEventSound(explosionSound);
		    circle = display.newCircle(bomb.x, bomb.y, 80);
			explosion = display.newImage("images/explosion.png", bomb.x, bomb.y);
			bomb:removeSelf();
			circle:setFillColor(0,0,0, 0);
			physics.addBody(circle, "static", {isSensor = true});
			circle.name = "circle";
			circle.collision = onLocalCollision;
			circle:addEventListener("collision", circle);
		 end

		 local function removeStuff(event)
			circle:removeSelf();
			explosion:removeSelf();
		 end
		 timer.performWithDelay(3000, blast);
		 timer.performWithDelay(3100, removeStuff);
	end
end

-------------------------
hai jalai style
if touched: stop rotation motor
ma ilig mga bato / tubig
------------------------
