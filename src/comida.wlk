import wollok.game.*
import obstaculo.*
import cancha.*
import defines.*

class Comida inherits Obstaculo
{
	override method tomar()
	{
		game.sound("comer.ogg")
		cancha.getScore().incrementar(-1)
		super()
	}
}
