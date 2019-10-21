import wollok.game.*
import obstacle.*
import field.*
import defines.*

class Beer inherits Obstacle
{
	override method initialize()
	{
		self.setup("cerveza.png", BEER_LIFE_MIN, BEER_LIFE_MAX)
	}
	
	override method take()
	{
		game.sound("cerveza.ogg")
		field.getPlayer().setDrunk(true)
		super()
	}
}
