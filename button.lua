module(..., package.seeall);

function new(params)
	local btn = display.newImage(params.image);
	btn.x = params.x;
	btn.y = params.y;
	btn.type = params.type;
	pop(btn);
	return btn;
end