import wollok.game.*
import obstaculo.*
import cancha.*
import defines.*

class Comida inherits Obstaculo
{
	override method tomar()
	{
		game.sound("comer.ogg")
		cancha.getPuntaje().incrementar(-1)
		super()
	}
}
