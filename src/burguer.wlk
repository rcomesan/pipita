import wollok.game.*
import food.*
import defines.*

class Burguer inherits Food
{
	override method initialize()
	{
		self.setup("hamburguesa.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
