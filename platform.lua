module(..., package.seeall);

function new(params)
	local platform = display.newImage(params.image);
	platform.type = "platform";
	platform.x = params.x;
	platform.y = params.y;
	_physics.addBody(platform, "static", { friction=0.5, bounce=0.3 });
	return platform;
end