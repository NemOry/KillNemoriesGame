module(..., package.seeall);

function new(params)
	local elesi = display.newImage("images/elesi.png");
	elesi.type = "enemy";
	elesi.x = params.x;
	elesi.y = params.y;
	
	elesi.xScale = 0.5;
	elesi.yScale = 0.5;
	transition.to(elesi, { time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic });
	
	_physics.addBody(elesi, "static", {radius = elesi.height / 2});
	
	return elesi;
end

