import "CoreLibs/sprites"
import "CoreLibs/graphics"


class('StatusBar').extends(playdate.graphics.sprite)
local gfx <const> = playdate.graphics
local f = gfx.font.new("font/ChicagoFLF-14")

function StatusBar:init()
	
	StatusBar.super.init(self)

	self.statusBarImage = gfx.image.new("img/statusbar")
	
	self:setImage(self.statusBarImage)
	self:setZIndex(-32768)
	self:setCenter(0, 0)	-- set center point to center bottom middle
	self:moveTo(6,189)
	self:setIgnoresDrawOffset(true)
	
	self:setCollideRect(-100, 0, self.width + 200, self.height)
	--self.position = point.new(102, 210)
	--self.velocity = vector2D.new(0,0)
end

function StatusBar:update()
	--self:markDirty()
end

