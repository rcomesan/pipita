import wollok.game.*
import time.*
import static_visual.*
import defines.*

class AnimatedVisual inherits StaticVisual
{
	var anims = []
	var animLooping = false
	
	var frameNumber = 0
	
	var animNumber = 0	
	var animSpeed = 1
	var animStartTime = 0
	
	var animNumberPrev = 0
	var animSpeedPrev = 0
	var animStartTimePrev = 0
	
	method setupVisual()
	{
		anims.add(["nada.png"])
		game.addVisual(self)
		
		game.onTick(16, "animated-visual-update", { self.update() })
	}
	
	method addAnimation(_animName, _numFrames)
	{
		var frames = []
		
		_numFrames.times({ i =>
			frames.add(_animName + "-" + (i - 1).toString() + ".png")	
		})
		
		anims.add(frames)
		return anims.size() - 1
	}
	
	method setAnimation(_animNumber, _speed, _inLoop)
	{
		if (_animNumber != animNumber)
		{
			animNumberPrev = animNumber
			animSpeedPrev = animSpeed
			animStartTimePrev = animStartTime
			
			animLooping = _inLoop
			animNumber = general.clamp(_animNumber, 0, anims.size() - 1)
			animSpeed = _speed
			animStartTime = time.getCounter()
		}
	}

	method update()
	{
		var anim = anims.get(animNumber)
		frameNumber = (time.getDelta(animStartTime) * animSpeed).truncate(0) % anim.size()
		
		if (!animLooping && frameNumber == anim.size() - 1)
		{
			animNumber = animNumberPrev
			animSpeed = animSpeedPrev
			animStartTime = animStartTimePrev
			frameNumber = 0
			
			animLooping = true
		}
	}
	
	override method image()
	{
		return anims.get(animNumber).get(frameNumber)
	}
}
