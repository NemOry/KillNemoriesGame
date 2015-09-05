module(..., package.seeall);

function new(params)
	local crate = display.newImage("images/crate.png");
	crate.type 	= "crate";
	crate.xScale = 0.5;
	crate.yScale = 0.5;
	if(params.x ~= nil and params.y ~= nil) then
		crate.x = params.x;
		crate.y = params.y;
	end	
	_physics.addBody(crate, params.bodyType, {density=1.0, friction=0.5, bounce=0.3});
	transition.to(crate, {time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic});
	
	local function removeCrate()
		crate:removeSelf();
		crate = nil;
	end
		
	function crate:touch()
		pop(self);
		timer.performWithDelay(200, removeCrate);
		return true;
	end
	
	crate:addEventListener("touch", crate);
	return crate;
end