import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('Level').extends(playdate.graphics.sprite)


local gfx <const> = playdate.graphics
local f = gfx.font.new("font/ChicagoFLF-14")

function Level:init()
	Level.super.init(self)
	self.img = gfx.image.new(200, 14)
	self:setZIndex(32767)
	self:setImage(self.img)
	self.displayedValue = ""
	self:moveTo(200,30)
	self:setVisible(false)
end


function Level:setValue(v)
	if self.displayedValue ~= v then
		self.img:clear(playdate.graphics.kColorClear)
		gfx.pushContext(self.img)
		
		gfx.setFont(f)
		gfx.drawTextAligned(v, 100, 0, kTextAlignment.center)
		gfx.popContext()
		self.displayedValue = v
	end
end