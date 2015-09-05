module(..., package.seeall);

function new(params)
	local stone = display.newImage("images/stone.png");
	stone.x = params.x;
	stone.y = params.y;
	
	_physics.addBody(stone, {density = 0.1, friction = 0.3, bounce = 0.3, radius = stone.width / 2});
	
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
		end
		return true;
	end

	stone:addEventListener( "touch", startDrag )
	return stone;
end