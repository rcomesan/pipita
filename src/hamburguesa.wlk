import wollok.game.*
import comida.*
import defines.*

class Hamburguesa inherits Comida
{
	method initialize()
	{
		self.setUp("hamburguesa.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
