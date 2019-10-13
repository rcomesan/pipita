import wollok.game.*
import defines.*
import living_object.*

class Obstaculo inherits LivingObject
{
	var image
	var position
	
	method position() = position
	method image() = image
	method tomar()

	method setUp(_image, _life)
	{
		image = _image
		
		// do until position is not in use
		position = general.getRndPos(
			new Position(x=RESPAWN_RANGE_MIN_X, y=RESPAWN_RANGE_MIN_Y), 
			new Position(x=RESPAWN_RANGE_MAX_X, y=RESPAWN_RANGE_MAX_Y)
		)
		
		game.addVisual(self)
		
		// initialize us as a living object
		self.init(_life)
	}
	
	method destroy()
	{
		game.removeVisual(self)
	}
}
