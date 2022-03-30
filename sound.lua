import "CoreLibs/sprites"

class('Sound').extends(playdate.graphics.sprite)

local snd <const> = playdate.sound

function Sound:init()
	Sound.super.init(self)
	self:setVisible(false)
	self.copterSound = snd.sampleplayer.new("sound/copter.wav")
	self.deathSound = snd.sampleplayer.new("sound/death.wav")
	self.successSoundTable = {}
	for i = 1, 4, 1
	do
		self.successSoundTable[i] = snd.sampleplayer.new("sound/success" .. tostring(i) .. ".wav")
	end
	self.newlevelSoundTable = {}
	for i = 1, 5, 1
	do
		self.newlevelSoundTable[i] = snd.sampleplayer.new("sound/newlevel" .. tostring(i) .. ".wav")
	end
	self.copterRunning = false
end

function Sound:startCopter()
	if not self.copterRunning then
		self.copterSound:play(0)
		self.copterRunning = true
	end
end

function Sound:stopCopter()
	if self.copterRunning then
		self.copterSound:stop()
		self.copterRunning = false
	end
end

function Sound:death()
	self.deathSound:play(1)
end

function Sound:success(v)
	self.successSoundTable[v]:play(1)
end

function Sound:newLevel(v)
	self.newlevelSoundTable[v]:play(1)
end