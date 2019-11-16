import wollok.game.*
import static_visual.*
import defines.*
import time.*

class LivingObject inherits StaticVisual
{
	var active = true
	var creationTime = 0
	
	var lifeMin = 0
	var lifeMax = 0
	var property totalLife = 0
	
	method setup(_image, _lifeMin, _lifeMax)
	{
		self.setupVisual(game.at(0, 0), _image)
		
		image = _image
		lifeMin = 0.max(_lifeMin)
		lifeMax = 60.min(_lifeMax)
		
		self.respawn()	
	}
	
	method currentLife()
	{
		return 0.max(totalLife - time.getDelta(creationTime))
	}
	
	method isAlive()
	{
		return active && self.currentLife() > 0
	}
	
	method kill()
	{
		active = false
	}
	
	method respawn()
	{
		active = true
		
		creationTime = time.getCounter()
		totalLife = general.getRndInt(lifeMin, lifeMax) + general.getRnd(-0.5, 0.5)
		position = general.getRndPos(
			new Position(x=RESPAWN_RANGE_MIN_X, y=RESPAWN_RANGE_MIN_Y), 
			new Position(x=RESPAWN_RANGE_MAX_X, y=RESPAWN_RANGE_MAX_Y)
		)
	}
}
