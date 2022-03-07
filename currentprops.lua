import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('CurrentProps').extends(playdate.graphics.sprite)


local gfx <const> = playdate.graphics
local f = gfx.font.new("font/ChicagoFLF-14")

function CurrentProps:init()
	CurrentProps.super.init(self)
	self.img = gfx.image.new(58, 14)
	self:setZIndex(32767)
	self:setCenter(0, 0)
	self:setImage(self.img)
	self.displayedValue = 0
end

function CurrentProps:draw()

	
end

function CurrentProps:update()
	
	--self:setImage(self.img) --needed?
	--self:markDirty()
end

function CurrentProps:setValue(v)
	if self.displayedValue ~= v then
		self.img:clear(playdate.graphics.kColorClear)
		gfx.pushContext(self.img)
		
		gfx.setFont(f)
		gfx.drawText(tostring(v), 0, 0)
		gfx.popContext()
		self.displayedValue = v
	end
end