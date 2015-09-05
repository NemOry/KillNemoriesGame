module(..., package.seeall);

function new(params)
	local pungkoyGroup = display.newGroup();
	
	local lansang = display.newRect(params.x, params.y, 10, 10);
	_physics.addBody(lansang, "static");
	
	local pungkoy = display.newImage("images/pungkoy.png");
	pungkoy.x = lansang.x + 45;
	pungkoy.y = lansang.y - 120;
	_physics.addBody(pungkoy, "dynamic", unpack(pungkoy_body));
	
	_physics.newJoint( "pivot", pungkoy, lansang, lansang.x, lansang.y, pungkoy.x, pungkoy.y);
	
	pungkoyGroup:insert(lansang);
	pungkoyGroup:insert(pungkoy);
	return pungkoyGroup;
end

pungkoy_body = 
{
	{
		density = 3,
		shape = {   -36, -111.5  ,  -49, -125.5  ,  49, -125.5  ,  49.5, -112  }
	}  ,
	{
		density = 3,
		shape = {   -37.5, -46.06103515625  ,  -49, -125.5  ,  -36, -111.5  }
	}  ,
	{
		density = 3,
		shape = {   -37, -32.969482421875  ,  -37.5, -46.06103515625  ,  49.469482421875, -46.030517578125  ,  49.5, -32.530517578125  }
	}  ,
	{
		density = 3,
		shape = {   -50, 124.969483543187  ,  -49, -125.5  ,  -37.5, -46.06103515625  ,  -37, -32.969482421875  ,  -36.5, 124.469483554363  }
	}  
}