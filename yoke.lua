import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('Yoke').extends(playdate.graphics.sprite)

local gfx <const> = playdate.graphics

function Yoke:init()
	
	Yoke.super.init(self)

	self.imageViewport = gfx.image.new(43, 43)
	self.yokeImage = gfx.image.new("img/yoke")
	self:setImage(self.imageViewport)
	self:setZIndex(32767)
	self:moveTo(32,215)	
	self.currentVelocityX = 0
	self.currentVelocityY = 0
	self:reset()
end

function Yoke:reset()
	self.x_velocity = 0
	self.y_velocity = 0
	self:MoveDisplayedYoke(self.x_velocity, self.y_velocity)
end

function Yoke:update()
	if gameOn then
		if playdate.buttonIsPressed("right") and playdate.buttonIsPressed("up") then
			self.x_velocity += 1
			self.y_velocity -= 1
		elseif playdate.buttonIsPressed("right") and playdate.buttonIsPressed("down") then
			self.x_velocity += 1
			self.y_velocity += 1
		elseif playdate.buttonIsPressed("left") and playdate.buttonIsPressed("up") then
			self.x_velocity -= 1
			self.y_velocity -= 1
		elseif playdate.buttonIsPressed("left") and playdate.buttonIsPressed("down") then
			self.x_velocity -= 1
			self.y_velocity += 1
		
		elseif playdate.buttonIsPressed("left") then self.x_velocity -= 1
		elseif playdate.buttonIsPressed("right") then self.x_velocity += 1
		elseif playdate.buttonIsPressed("up") then self.y_velocity -= 1
		elseif playdate.buttonIsPressed("down") then self.y_velocity += 1
		end
		
		if self.x_velocity < -15 then self.x_velocity = -15 end
		if self.x_velocity > 15 then self.x_velocity = 15 end
		if self.y_velocity < -15 then self.y_velocity = -15 end
		if self.y_velocity > 15 then self.y_velocity = 15 end
		
		self:MoveDisplayedYoke(self.x_velocity, self.y_velocity)
	end
end

function Yoke:MoveDisplayedYoke(x, y)
	
	if x ~= self.currentVelocityX or y ~= self.currentVelocityY then
		self.imageViewport:clear(gfx.kColorClear)
		gfx.pushContext(self.imageViewport)
		self.yokeImage:drawCentered(22 + x, 22 + y)
		gfx.popContext()
		
		self.currentVelocityX = x
		self.currentVelocityY = y
	end
end

