import wollok.game.*
import timer.*
import defines.*

class AnimatedVisual
{
	var numFrames
	var speed
	
	var anims = []
	var animNumber = 0
	
	var position = game.at(0, 0)
		
	method setUpVisual()
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
	
	method setAnimation(_animNumber)
	{
		animNumber = general.clamp(_animNumber, 0, anims.size() - 1)
	}

	method position()
	{
		return position
	}
	
	method image()
	{
		var anim = anims.get(animNumber)
		return anim.get((timer.getCounter() * ANIM_SPEED).truncate(0) % anim.size())
	}
}
