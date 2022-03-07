import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "statusbar"

class('Jumper').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local point <const> = playdate.geometry.point
local vector2D = playdate.geometry.vector2D

local COPTER_X_OFFSET <const> = 10
local COPTER_Y_OFFSET <const> = 25

function Jumper:init()
	
	Jumper.super.init(self)

	self.jumperImageTable = gfx.imagetable.new("img/jumper")
		
	self:setImage(self.jumperImageTable:getImage(1))
	self:setZIndex(1000)
	self:setCenter(0.5, 1)	-- set center point to center bottom middle
	
	self:setCollideRect(0, 0, self:getSize())
	--self.position = point.new(102, 210)
	--self.velocity = vector2D.new(0,0)
	self:reset()
	
end

function Jumper:reset()
	self.currentImageIndex = 1
	self.slowFrameSkip = true
	self.falling = false
	self.splatting = false
	self.splatted = false
	self:moveTo(1, 1)
end

function Jumper:isOnScreen()
	if self.x > 0 and self.x <= 400  then
		return true
	else
		return false
	end
end

function Jumper:update()
	if self.falling and not self.splatting then	
		if not self.slowFrameSkip then
			self.currentImageIndex += 1
			self.slowFrameSkip = false
		else
			self.slowFrameSkip = false
		end
		if self.currentImageIndex > 6 then self.currentImageIndex = 1 end
	elseif self.splatting then
		print(self.currentImageIndex)
		if not self.slowFrameSkip then
			self.currentImageIndex += 1
			self.slowFrameSkip = true
		else
			self.slowFrameSkip = false
		end
		if self.currentImageIndex > 12 then
			self.splatting = false
			self.splatted = true
		end
	elseif self.splatted then ;
		
	else
		self.currentImageIndex = 1
	end
	
	self:setImage(self.jumperImageTable[self.currentImageIndex])
	--Jumper.super.update(self)
	
end

function Jumper:moveWithCopter(copterX, copterY)
	if not self.falling then
		self:moveTo(copterX + COPTER_X_OFFSET, copterY + COPTER_Y_OFFSET)
	end
	-- self.position = point.new(copterX, copterY)
end

function Jumper:isFalling()
	return self.falling
end

function Jumper:isSplatting()
	return self.splatting
end

function Jumper:isSplatted()
	return self.splatted
end

function Jumper:startFalling()
	self.falling = true
end

function Jumper:startSplat()
	self.falling = false
	self.splatting = true
	self.currentImageIndex = 7
end

function Jumper:goAway()
	self.falling = false
	self.splatted = true
	self:setVisible(false)
end

function Jumper:collisionResponse(other)
	print("collision")
	if other:isa(StatusBar) then
			return "freeze"
	end

	return "overlap"
end
