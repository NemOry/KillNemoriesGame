module(..., package.seeall);

function new(params)
	local punso = display.newImage("images/punso.png");
	punso.x = params.x;
	punso.y = params.y;
	_physics.addBody(punso, unpack(punso_body));
	return punso;
end