import wollok.game.*
import time.*
import defines.*

class AnimatedVisual
{
	var anims = []
	var animLooping = false
	
	var animNumber = 0	
	var animSpeed = 1
	var animStartTime = 0
	
	var animNumberPrev = 0
	var animSpeedPrev = 0
	var animStartTimePrev = 0
	
	var position = game.at(0, 0)
		
	method setupVisual()
	{
		anims.add(["nada.png"])
		game.addVisual(self)
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

	method position()
	{
		return position
	}
	
	method image()
	{
		var anim = anims.get(animNumber)
		var frameNumber = (time.getDelta(animStartTime) * animSpeed).truncate(0) % anim.size()
		
		if (!animLooping && frameNumber == anim.size() - 1)
		{
			animNumber = animNumberPrev
			animSpeed = animSpeedPrev
			animStartTime = animStartTimePrev

			animLooping = true
		}
		
		return anim.get(frameNumber)
	}
}
