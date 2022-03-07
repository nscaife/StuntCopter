import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('Score').extends(playdate.graphics.sprite)


local gfx <const> = playdate.graphics
local f = gfx.font.new("font/scorefont")

function Score:init()
	Score.super.init(self)
	self.img = gfx.image.new(120, 15)
	self:setZIndex(32767)
	self:setCenter(0, 0)
	self:setImage(self.img)
	self.displayedValue = 0
end

function Score:draw()

	
end

function Score:update()
	
	--self:setImage(self.img) --needed?
	--self:markDirty()
end

function Score:setValue(v)
	if self.displayedValue ~= v then
		print(tostring(v))
		self.img:clear(playdate.graphics.kColorClear)
		gfx.pushContext(self.img)
		
		gfx.setFont(f)
		gfx.drawText(tostring(v), 0, 0)
		gfx.popContext()
		self.displayedValue = v
	end
end