import wollok.game.*
import defines.*
import tablero.*
import timer.*

class Reloj inherits Tablero
{
	var position = game.at(1, FIELD_TILES_HEIGHT - 3)
	var image = "tiempo.png"
	var startTime = 0
	var seconds = 60
	
	method initialize()
	{		
		self.b_initialize(position.right(1))
		startTime = timer.getCounter()

		game.addVisual(self)
	}

	method destroy()
	{
		self.b_destroy()
		game.removeVisual(self)
	}

	method position()
	{
		self.setValue(self.timeRemaining())
		return position
	}
	
	method image()
	{
		return image		
	}
	
	method timeRemaining()
	{
		return seconds - timer.getDelta(startTime).truncate(0) 		
	}
}
