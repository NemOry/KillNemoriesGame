module(..., package.seeall);

function new(params)
	local beam = display.newImage( "images/beam_long.png" );
	beam.x = 280; beam.y = 50
	physics.addBody( beam, "static", { friction=0.5 } )

	beam.x = params.x;
	beam.y = params.y;
	
	local myJoints 	= {}
	local link 		= {}
		
	for i = 1,2 do
		for j = 1,17 do
			link[j] = display.newImage("images/link.png" );
			link[j].x = 121 + (i*34);
			link[j].y = 55 + (j*17);
			physics.addBody(link[j], { density=2.0, friction=0.2, bounce=0 } );
			
			if (j > 1) then
				prevLink = link[j-1]; -- each link is joined with the one above it
			else
				prevLink = beam; -- top link is joined to overhanging beam
			end
			myJoints[#myJoints + 1] = physics.newJoint("pivot", prevLink, link[j], 121 + (i*34), 46 + (j*17) );
		end
	end
end