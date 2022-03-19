import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('Thumb').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics

function Thumb:init()
	
	Thumb.super.init(self)

	self.thumbImageTable = gfx.imagetable.new("img/thumb")
		
	self:setImage(self.thumbImageTable:getImage(1))
	self:setZIndex(32767)
	self:setCenter(0,0)
	self.down = false
end

function Thumb:reset()
	self:setUp()
	self:setVisible(false)
end

function Thumb:update()
	self:setImage(self.thumbImageTable:getImage(self.currentImageIndex))
end

function Thumb:setUp()
	if self.down then --need to move up
		self:moveTo(self.x, self.y - 17)
	end
	self.currentImageIndex = 1
	self.down = false
	self:setVisible(true)
end

function Thumb:setDown()
	if not self.down then --need to move down
		self:moveTo(self.x, self.y + 17)
	end
	self.currentImageIndex = 2
	self.down = true
	self:setVisible(true)
end