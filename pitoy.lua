module(..., package.seeall);

function new(params)
	local penisGroup = display.newGroup();
	
	local penis_head = display.newImage("images/penis_head.png");
	_physics.addBody(penis_head, {friction = 0.4, bounce = 0});
	penis_head.x = params.x;
	penis_head.y = params.y;
	
	local penis_body = display.newImage("images/penis_body.png");
	_physics.addBody(penis_body, "static", {friction = 0.4, bounce = 0});
	penis_body.x = params.x;
	penis_body.y = params.y;

	local joint = _physics.newJoint( "piston", penis_body, penis_head, penis_body.x, penis_body.y, 0, -1);
	joint.isMotorEnabled = true;
	joint.motorSpeed = 5000;
	joint.maxMotorForce = 500;
	joint.isLimitEnabled = true;
	joint:setLimits(0, 35);
	
	penisGroup:insert(penis_head);
	penisGroup:insert(penis_body);
	
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

	penis_head:addEventListener("touch", startDrag);
	return penisGroup;
end