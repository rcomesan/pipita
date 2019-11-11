import wollok.game.*
import obstacle.*
import field.*
import defines.*

object frenchFries 
{
	method image() = "papas.png"
}

object hotDog
{
	method image() = "pancho.png"
}

object burguer 
{
	method image() = "hamburguesa.png"
}

class Food inherits Obstacle
{
	var foodType

	override method initialize()
	{
		self.setup(foodType.image(), FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
	
	override method take()
	{
		game.sound("comer.ogg")
		field.getScore().increment(-1)
		super()
	}
}
