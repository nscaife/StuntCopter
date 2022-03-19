import "CoreLibs/sprites"
import "CoreLibs/graphics"


class('Copter').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

function Copter:init()
	
	Copter.super.init(self)


	self.copterImageTable = gfx.imagetable.new("img/copter")
	self:setImage(self.copterImageTable:getImage(1))
	self:setZIndex(1000)
	--self:setCenter(0, 0)	-- set center point to center bottom middle
	self:moveTo(45, 45)
		
	self.position = geo.point.new(45, 45)
	--self.velocity = vector2D.new(0,0)
	
	self.currentImageIndex = 1
	self.slowFrameSkip = true
end


function Copter:update()
	if not slowFrameSkip then
		self.currentImageIndex += 1
		self.slowFrameSkip = true
	else
		self.slowFrameSkip = false
	end
	if self.currentImageIndex > 3 then self.currentImageIndex = 1 end
	self:setImage(self.copterImageTable[self.currentImageIndex])	
end

function Copter:getHeight()
	return COPTER_MAX_HEIGHT - self.position.y
end