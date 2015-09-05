system.activate( "multitouch" );
require("super_globals");

local director = require("director");
local mainGroup = display.newGroup();

local function main()
	mainGroup:insert(director.directorView);
	director:changeScene("menu");
	return true;
end

main();

-- local sprite = require("sprite")
-- local spriteSheet = sprite.newSpriteSheet("images/monsterSpriteSheet.png", 100, 100)
-- local monsterSet = sprite.newSpriteSet(spriteSheet, 1, 7)
-- sprite.add(monsterSet, "running", 1, 6, 600, 0)
-- sprite.add(monsterSet, "jumping", 7, 7, 1, 1)
-- local hero = sprite.newSprite(monsterSet)
-- hero:prepare("running")
-- hero:play()