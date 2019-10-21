import wollok.game.*
import food.*
import defines.*

class FrenchFries inherits Food
{
	override method initialize()
	{
		self.setup("papas.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
