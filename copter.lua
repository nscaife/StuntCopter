import "CoreLibs/sprites"
import "CoreLibs/graphics"


class('Copter').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local COPTER_MAX_HEIGHT <const> = 188--139
local COPTER_MIN_HEIGHT <const> = 46
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
	
	if playdate.buttonIsPressed("right") and playdate.buttonIsPressed("up") then
		self.position:offset(1, -1)
	elseif playdate.buttonIsPressed("right") and playdate.buttonIsPressed("down") then
		self.position:offset(1, 1)
	elseif playdate.buttonIsPressed("left") and playdate.buttonIsPressed("up") then
		self.position:offset(-1, -1)
	elseif playdate.buttonIsPressed("left") and playdate.buttonIsPressed("down") then
		self.position:offset(-1, 1)
	
	elseif playdate.buttonIsPressed("left") then self.position:offset(-1, 0)
	elseif playdate.buttonIsPressed("right") then self.position:offset(1, 0)
	elseif playdate.buttonIsPressed("up") then self.position:offset(0, -1)
	elseif playdate.buttonIsPressed("down") then self.position:offset(0, 1)
	end
	
	if not slowFrameSkip then
		self.currentImageIndex += 1
		self.slowFrameSkip = true
	else
		self.slowFrameSkip = false
	end
	if self.currentImageIndex > 3 then self.currentImageIndex = 1 end
	self:setImage(self.copterImageTable[self.currentImageIndex])
	
	if self.position.y < 0 then self.position.y = 0 end
	if self.x > 435 then self.position.x = -70 end
	if self.x < -70 then self.position.x = 435 end
	if self:getHeight() < COPTER_MIN_HEIGHT then self.position.y = COPTER_MAX_HEIGHT - COPTER_MIN_HEIGHT end
end

function Copter:getHeight()
	return COPTER_MAX_HEIGHT - self.position.y
end