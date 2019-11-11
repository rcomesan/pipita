import wollok.game.*
import obstacle.*
import player.*
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
		player.setDrunk()
		super()
	}
}
