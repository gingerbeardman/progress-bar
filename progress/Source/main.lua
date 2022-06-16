import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

local playerSprite = nil

local progressPercent = 0

playdate.display.setRefreshRate(20)

function myGameSetUp()

    local progressImage = gfx.imagetable.new("Images/progress-dither")
    assert( progressImage )

    infillSprite = gfx.sprite.new( progressImage[1] )
    infillSprite:moveTo( 200, 200 )
    infillSprite:add()
	
    progressSprite = gfx.sprite.new( progressImage[3] )
    progressSprite:moveTo( 200, 200 )
	updateProgress()
    progressSprite:add()

    surroundSprite = gfx.sprite.new( progressImage[2] )
    surroundSprite:moveTo( 200, 200 )
    surroundSprite:add()

    local backgroundImage = gfx.image.new( "Images/background" )
    assert( backgroundImage )
    
    gfx.sprite.setBackgroundDrawingCallback(
        function( x, y, width, height )
            gfx.setClipRect( x, y, width, height )
            backgroundImage:draw( 0, 0 )
            gfx.clearClipRect()
        end
    )

end

function updateProgress()
	progressSprite:setClipRect(progressSprite.x-progressSprite.width/2,progressSprite.y-progressSprite.height/2,progressPercent*2,progressSprite.height)
end

myGameSetUp()

function playdate.update()

    progressPercent = progressPercent + (math.random(0,4)//2)
	if progressPercent > 120 then progressPercent = -20 end
	updateProgress()

    gfx.sprite.update()
    playdate.timer.updateTimers()

end