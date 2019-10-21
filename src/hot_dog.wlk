import wollok.game.*
import food.*
import defines.*

class HotDog inherits Food
{
	override method initialize()
	{
		self.setup("pancho.png", FOOD_LIFE_MIN, FOOD_LIFE_MAX)
	}
}
