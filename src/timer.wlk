import wollok.game.*
import defines.*
import numeric_board.*
import time.*

class Timer inherits NumericBoard
{
	var startTime = 0
	var seconds = 60
	
	override method initialize()
	{	
		game.onTick(500, "timer-update", { self.update() })
		self.setup(game.at(1, FIELD_TILES_HEIGHT - 3), "tiempo.png", true)		
		self.reset()
	}

	override method reset()
	{
		super()
		startTime = time.getCounter()
	}
	
	method update()
	{
		self.setValue(self.getTimeRemaining())
	}
	
	method getTimeRemaining()
	{
		return seconds - time.getDelta(startTime).truncate(0) 		
	}
}
