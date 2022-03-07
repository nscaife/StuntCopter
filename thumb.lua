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
	self.currentImageIndex = 1
end


function Thumb:update()
	self:setImage(self.thumbImageTable:getImage(self.currentImageIndex))
end

function Thumb:setUp()
	self.currentImageIndex = 1
end

function Thumb:setDown()
	self:moveTo(self.x, self.y + 17)
	self.currentImageIndex = 2
end