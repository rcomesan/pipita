import wollok.game.*
import comida.*
import defines.*

class Papas inherits Comida
{
	method initialize()
	{
		self.setUp("papas.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
