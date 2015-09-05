module(..., package.seeall);

function new(params)
	local karitoGroup = display.newGroup();
	
	local karito = display.newImage("images/karito.png");
	karito.x = params.x;
	karito.y = params.y;

	_physics.addBody(karito, unpack(karito_body));

	local royda1 = display.newImage("images/elesi.png");
	royda1:scale(0.3, 0.3);
	royda1.x = params.x - ((karito.width / 2) - 10);
	royda1.y = params.y + (karito.height / 2);
	_physics.addBody(royda1, "dynamic", {density = 0.2, friction = 0.5, bounce = 0.5, radius = royda1.width / 6});

	local royda2 = display.newImage("images/elesi.png");
	royda2:scale(0.3, 0.3);
	royda2.x = params.x + ((karito.width / 2) + 20);
	royda2.y = params.y + (karito.height / 2);
	_physics.addBody(royda2, "dynamic", {density = 0.2, friction = 0.5, bounce = 0.5, radius = royda2.width / 6});

	local joint1 = _physics.newJoint( "pivot", royda1, karito, royda1.x, royda1.y, karito.x, karito.y);
	local joint2 = _physics.newJoint( "pivot", royda2, karito, royda2.x, royda2.y, karito.x , karito.y);
	
	karitoGroup:insert(karito);
	karitoGroup:insert(royda1);
	karitoGroup:insert(royda2);
	
	return karitoGroup;
end

karito_body = 
{
	{
		density = 0.1, friction = 0.1, bounce = 0.5, 
		shape = {   -61.5, -33.5  ,  -29, -17  ,  -34.5, -12.5  ,  -64, -23  }
	}  ,
	{
		density = 0.1, friction = 0.1, bounce = 0.5, 
		shape = {   -27, 31  ,  -34, 38  ,  -34.5, -12.5  ,  -29, -17  }
	}  ,
	{
		density = 0.1, friction = 0.1, bounce = 0.5, 
		shape = {   -27, 31  ,  63, 32.5  ,  64.5, 37.5  ,  -34, 38  }
	}  
}