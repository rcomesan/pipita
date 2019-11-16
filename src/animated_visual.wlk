import wollok.game.*
import time.*
import static_visual.*
import defines.*

class AnimState
{
	var property number
	var property looping
	var property speed
	var property startTime
	var property frame
}

class AnimatedVisual inherits StaticVisual
{
	var anims = []
	
	var curAnim
	var prevAnim
	var setAnim
	
	method setupVisual()
	{
		anims.add(["nada.png"])
		game.addVisual(self)
		
		game.onTick(16, "animated-visual-update", { self.update() })
		
		curAnim = new AnimState()
		prevAnim = new AnimState()
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
		setAnim = new AnimState(
			number=general.clamp(_animNumber, 0, anims.size() - 1),
			looping=_inLoop,
			speed=_speed,
			startTime=0,
			frame=0			
		)
	}

	method update()
	{
		if (null != setAnim)
			self.setPendingAnim()
		
		var anim = anims.get(curAnim.number())
		curAnim.frame((time.getDelta(curAnim.startTime()) * curAnim.speed()).truncate(0) % anim.size())
		
		if (!curAnim.looping() && curAnim.frame() >= anim.size() - 1)
		{
			curAnim = prevAnim		
		}
	}
	
	override method image()
	{
		return anims.get(curAnim.number()).get(curAnim.frame())
	}
	
	method setPendingAnim()
	{
		if (setAnim.number() != curAnim.number())
		{
			prevAnim = curAnim
			curAnim = setAnim
			curAnim.startTime(time.getCounter())
		}

		setAnim = null
	}
}
