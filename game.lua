import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "copter"
import "jumper"
import "statusbar"
import "wagon"
import "currentprops"
import "score"
import "thumb"

class('Game').extends(playdate.graphics.sprite)
local gfx <const> = playdate.graphics

local GAMEOVER_NORMAL <const> = 0
local GAMEOVER_DRIVER <const> = 1
local GAMEOVER_HORSE <const>  = 2

local debug_x = -1
local debug_y = -1
local debug_x2 = -1
local debug_y2 = -1
local debug_rect
local debug_rect2

gameOn = true

function Game:init()
	
	Game.super.init(self)

	self.successAnimationFrameCount = -1
	self.currentScore = 0
	self.currentHiScore = 0
	self.currentTry = 1
	self.heightAtJump = 0
	
	self.jumper = Jumper()
	self.copter = Copter()
	self.wagon = Wagon()
	self.statusbar = StatusBar()
	self.displayedHeight = CurrentProps()
	self.displayedSpeed = CurrentProps()
	self.displayedGravity = CurrentProps()
	self.displayedScore = Score()
	self.displayedHiScore = Score()

	
	self.displayedHeight:moveTo(330,189)
	self.displayedSpeed:moveTo(330,206)
	self.displayedGravity:moveTo(330,222)
	self.displayedScore:moveTo(143,199)
	self.displayedHiScore:moveTo(143,224)
	
	
	gfx.sprite.add(self.jumper)
	gfx.sprite.add(self.copter)
	gfx.sprite.add(self.statusbar)
	gfx.sprite.add(self.wagon)
	gfx.sprite.add(self.displayedHeight)
	gfx.sprite.add(self.displayedSpeed)
	gfx.sprite.add(self.displayedGravity)
	gfx.sprite.add(self.displayedScore)
	gfx.sprite.add(self.displayedHiScore)
	
	self.thumbTable = {}
	for i = 1, 5, 1
	do
		self.thumbTable[i] = Thumb()
		self.thumbTable[i]:setVisible(false)
		self.thumbTable[i]:moveTo(45 + 15*i,206)
		gfx.sprite.add(self.thumbTable[i])
	end
	
	

end

function Game:reset()

end

function Game:update()
	
	if gameOn then
		
		if self.currentTry > 5 then
			self:GameOver(GAMEOVER_NORMAL)
		end
		
		
		self.copter:moveTo(self.copter.position)
		self.wagon:moveTo(self.wagon.position)
		
		if self.successAnimationFrameCount >= 0 then
			self.successAnimationFrameCount += 1
			if self.successAnimationFrameCount > 60 then
				self:stopSuccessfulLanding()
			end
			-- don't do anything else
			return
		end
		
		if playdate.buttonIsPressed("a") and not self.jumper:isFalling() and not self.jumper:isSplatting() and not self.jumper:isSplatted() and self.jumper:isOnScreen() then
			self.heightAtJump = self.copter:getHeight()
			self.jumper:startFalling()
		elseif self.jumper:isFalling() then
			local collisions, len, x, y
			x, y, collisions, len = self.jumper:moveWithCollisions(self.jumper.x, self.jumper.y + 1)
			for i = 1, len do		
				local c = collisions[i]
				if c.other:isa(StatusBar) then
					self.jumper:startSplat()
					self.thumbTable[self.currentTry]:setDown()
					self.thumbTable[self.currentTry]:setVisible(true)
					self.currentTry += 1
					
					break
				elseif c.other:isa(Wagon) then
					-- we need to figure out where on the wagon it collided
					
					local dist = math.abs(self.jumper.x - self.wagon.x)
					print("dist: " .. tostring(dist))
					if dist <= 33 then
						print("jump success! " .. tostring(self.heightAtJump))
						self:startSuccessfulLanding()
						self.currentScore += self.heightAtJump
						self.thumbTable[self.currentTry]:setVisible(true)
						self.currentTry += 1
					elseif dist < 46 then
						print("jump kills driver!")
						self.thumbTable[self.currentTry]:setDown()
						self.thumbTable[self.currentTry]:setVisible(true)
						self:GameOver(GAMEOVER_DRIVER)
					else
						print("jump kills horse!")
						self.thumbTable[self.currentTry]:setDown()
						self.thumbTable[self.currentTry]:setVisible(true)
						self:GameOver(GAMEOVER_HORSE)
					end
					break
				end	
			end
			
			
		elseif self.jumper:isSplatting() then ;
		elseif self.jumper:isSplatted() then
			self.jumper:reset()
			self.jumper:moveWithCopter(self.copter.position.x, self.copter.position.y)
		else
			self.jumper:moveWithCopter(self.copter.position.x, self.copter.position.y)
		end
		
		--gfx.drawText(self.copter:getHeight(), 330, 189)
		
		-- refresh all of the displayed values
		self.displayedHeight:setValue(self.copter:getHeight())
		self.displayedSpeed:setValue("WALK")
		self.displayedGravity:setValue("LOW")
		self.displayedScore:setValue(string.format("%06d", self.currentScore))
		self.displayedHiScore:setValue(string.format("%06d", self.currentHiScore))
		
	end
end

function Game:startSuccessfulLanding()
	self.jumper:setVisible(false)
	self.jumper:setUpdatesEnabled(false)
	self.wagon:startSuccessfulLanding()
	self.successAnimationFrameCount = 0
end

function Game:stopSuccessfulLanding()
	self.jumper:setVisible(true)
	self.jumper:setUpdatesEnabled(true)
	self.jumper:reset()
	self.wagon:stopSuccessfulLanding()
	self.successAnimationFrameCount = -1
	
	-- go ahead and move the jumper. if you hold the jump button, will sometimes jump at 1,1
	self.jumper:moveWithCopter(self.copter.position.x, self.copter.position.y)
	
end

function Game:GameOver(reason)
	
	gameOn = false


	if reason == GAMEOVER_NORMAL then
		assert(false)
	elseif reason == GAMEOVER_DRIVER then
		self.wagon:hitDriver()
		self.jumper:setVisible(false)
	elseif reason == GAMEOVER_HORSE then
		self.wagon:hitHorse()
		self.jumper:setVisible(false)
	end

		
	--self.copter:setUpdatesEnabled(false)
	self.jumper:setUpdatesEnabled(false)
	self.wagon:setUpdatesEnabled(false)
end


function playdate.debugDraw()
	if debug_x >= 0 and debug_y >= 0 then
		gfx.drawPixel(debug_x, debug_y)
		gfx.drawPixel(debug_x2, debug_y2)
		
		--gfx.drawRect(debug_rect)
		--gfx.drawRect(debug_rect2)
		--assert(false)
	end
end