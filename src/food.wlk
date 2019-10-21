import wollok.game.*
import obstacle.*
import field.*
import defines.*

class Food inherits Obstacle
{
	override method take()
	{
		game.sound("comer.ogg")
		field.getScore().increment(-1)
		super()
	}
}
