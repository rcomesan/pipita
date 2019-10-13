import wollok.game.*
import obstaculo.*
import cancha.*
import defines.*

class Hamburguesa inherits Obstaculo
{
	method initialize()
	{
		self.setUp("hamburguesa.png", general.getRnd(BURGUER_LIFE_MIN, BURGUER_LIFE_MAX))
	}
	
	override method tomar()
	{
		game.sound("comer.ogg")
		cancha.getPuntaje().incrementar(-1)
		self.kill()
	}
}
