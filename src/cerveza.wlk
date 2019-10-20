import wollok.game.*
import obstaculo.*
import cancha.*
import defines.*

class Cerveza inherits Obstaculo
{
	method initialize()
	{
		self.setUp("cerveza.png", BEER_LIFE_MIN, BEER_LIFE_MAX)
	}
	
	override method tomar()
	{
		game.sound("cerveza.ogg")
		cancha.getJugador().setDrunk(true)
		super()
	}
}
