import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('Wagon').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

function Wagon:init()
	
	Wagon.super.init(self)

	self.wagonImageTable = gfx.imagetable.new("img/wagon")
		
	self:setImage(self.wagonImageTable:getImage(1))
	self:setZIndex(0)
	self:setCenter(0,0)
	self:setCollideRect(0, 0, self.width, self.height - 3)
	self.position = geo.point.new(30, 167)
	self.currentImageIndex = 1
	self.slowFrameSkip = true
	self.animateSuccess = false
	self.status = {"WALK", "TROT", "GALLOP"}
	self.speed = 1
end


function Wagon:update()
	
	if gameOn then
		if not self.slowFrameSkip then
			self.currentImageIndex += 1
			self.slowFrameSkip = true
		else
			self.slowFrameSkip = false
		end
		
		if self.animateSuccess then
			if self.currentImageIndex > 8 then self.currentImageIndex = 6 end
		else
			if self.currentImageIndex > 3 then self.currentImageIndex = 1 end
		
		end
		self.position.x += self.speed
			
		if self.x > 400 then self.position.x = -70
		elseif self.x < -70 then self.position.x = 400 end
	
		self:setImage(self.wagonImageTable[self.currentImageIndex])
	end
	
end

function Wagon:startSuccessfulLanding()
	print("startSuccessfulLanding")
	self.animateSuccess = true
	self.currentImageIndex = 6
end

function Wagon:stopSuccessfulLanding()
	print("stopSuccessfulLanding")
	self.animateSuccess = false
	self.currentImageIndex = 1
end

function Wagon:hitDriver()
	self:setImage(self.wagonImageTable[4])
end

function Wagon:hitHorse()
	self:setImage(self.wagonImageTable[5])
end

function Wagon:setSpeed(s)
	self.speed = s
end

function Wagon:getStatus()
	return self.status[self.speed]
end