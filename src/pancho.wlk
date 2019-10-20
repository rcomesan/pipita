import wollok.game.*
import comida.*
import defines.*

class Pancho inherits Comida
{
	method initialize()
	{
		self.setUp("pancho.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
