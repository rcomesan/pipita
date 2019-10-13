import wollok.game.*
import obstaculo.*
import cancha.*
import defines.*

class Cerveza inherits Obstaculo
{
	method initialize()
	{
		self.setUp("cerveza.png", general.getRnd(BEER_LIFE_MIN, BEER_LIFE_MAX))
	}
	
	override method tomar()
	{
		game.sound("cerveza.ogg")
		cancha.getPlayer().setDrunk(true)
		self.kill()
	}
}
