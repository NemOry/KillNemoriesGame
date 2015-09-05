module(..., package.seeall);

function new(params)
	local virus = display.newImage("images/virus.png");
	virus.type = "enemy";
	virus.x = params.x;
	virus.y = params.y;
	
	btn.xScale = 0.5;
	btn.yScale = 0.5;
	transition.to(virus, { time = 1000, xScale = 1.0, yScale = 1.0, transition = _easingx.easeOutElastic });
	
	local virus_body = {};
	virus_body["vertices"] = 
	{
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -5.5, -48.5  ,  5.5, -48.5  ,  0.5, -7.5  ,  -14.5, 20.5  ,  -54.5, -13.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   49.5, 20.5  ,  47.5, 21.5  ,  13.5, 17.5  ,  0.5, -7.5  ,  49.5, -10.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   41.5, 26.5  ,  13.5, 17.5  ,  47.5, 21.5  ,  45.5, 26.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   20.5, 41.5  ,  -47.5, 43.5  ,  20.5, 35.5  ,  22.5, 40.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -39.5, 38.5  ,  -47.5, 43.5  ,  -43.5, 39.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -31.5, 33.5  ,  -39.5, 38.5  ,  -35.5, 34.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -15.5, 23.5  ,  13.5, 17.5  ,  -31.5, 33.5  ,  -27.5, 29.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -47.5, 43.5  ,  -31.5, 33.5  ,  13.5, 17.5  ,  20.5, 35.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   13.5, 17.5  ,  -15.5, 23.5  ,  -14.5, 20.5  ,  0.5, -7.5  }
		}   ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   14, 15.5  ,  0.5, -10  ,  49, -12.5  ,  45, 25.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   0.5, -10  ,  -16, 18.5  ,  -50, -8.5  ,  4, -55.5  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   14, 15.5  ,  25.5, 40  ,  -16, 18.5  ,  0.5, -10  }
		}  ,
		{
			density = 2, friction = 0.5, bounce = 0.3, 
			filter = { categoryBits = 1, maskBits = 65535 },
			shape = {   -47, 41.5  ,  -16, 18.5  ,  25.5, 40  }
		} 
	} 
	
	--_physics.addBody(virus, "dynamic", { density = 0.3, friction=0.5, bounce=0.3 });
	_physics.addBody(virus, unpack(virus_body["vertices"]));
	virus:addEventListener("collision", virus);
	
	return virus;
end