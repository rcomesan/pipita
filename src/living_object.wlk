import wollok.game.*
import defines.*
import timer.*

class LivingObject
{
	var active = true
	var creationTime = 0
	
	var lifeMin = 0
	var lifeMax = 0
	var totalLife = 0
	
	var image = "nada.png"
	var position = game.at(0, 0)
	
	method init(_image, _lifeMin, _lifeMax)
	{
		game.addVisual(self)
		
		image = _image
		lifeMin = 0.max(_lifeMin)
		lifeMax = 60.min(_lifeMax)
		
		self.respawn()	
	}
	
	method position()
	{
		return position		
	}
	
	method image()
	{
		return image
	}
	
	method totalLife()
	{
		return totalLife
	}
	
	method getLife()
	{
		return 0.max(totalLife - timer.getDelta(creationTime))
	}
	
	method isAlive()
	{
		return active && self.getLife() > 0
	}
	
	method kill()
	{
		active = false
	}
	
	method respawn()
	{
		active = true
		
		creationTime = timer.getCounter()
		totalLife = general.getRndInt(lifeMin, lifeMax) + general.getRnd(-0.5, 0.5)
		
		position = general.getRndPos(
			new Position(x=RESPAWN_RANGE_MIN_X, y=RESPAWN_RANGE_MIN_Y), 
			new Position(x=RESPAWN_RANGE_MAX_X, y=RESPAWN_RANGE_MAX_Y)
		)		
	}
}
