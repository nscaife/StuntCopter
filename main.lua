import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "game"

local gfx <const> = playdate.graphics
local copterImageTable = gfx.imagetable.new("img/copter")
local carriageImageTable = gfx.imagetable.new("img/carriage")
local statusbarImage = gfx.image.new("img/statusbar")
local f = gfx.font.new("font/ChicagoFLF-14")

local game = Game()
gfx.sprite.add(game)

function playdate.update()
	--gfx.clear()
	
	--gfx.setFont(f)
	gfx.sprite.update()
	
	--a:draw(x, y)
	--b:draw(cx, cy)
	
	-- jumper:moveTo(x, y)
	--cx = cx + 1
	--if cx == 400 then cx = -70 end
	--statusbarImage:draw(6,189)
	--gfx.drawText(copter:getHeight(), 330, 189)
	--gfx.drawText("TEST", 200, 200)
	-- gfx.drawTextInRect("*" .. tostring(y) .. "*", 330, 189, 59, 20)
	playdate.drawFPS(1,1)
	
end