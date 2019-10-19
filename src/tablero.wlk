import wollok.game.*
import defines.*

class Tablero
{
	var value = 0
	var texture = null
	
	method setUp(_position)
	{
		self.reset()

		texture = object 
		{
			var img = []
			
			method initialize()
			{
				61.times({ i =>
					img.add("num-" + (i - 1) + ".png")
				})
			}
			
			method position() = _position
			method image() = img.get(value)	
		}
		game.addVisual(texture)		
	}
	
	method reset()
	{
		self.setValue(0)
	}

	method setValue(_value)
	{
		value = general.clamp(_value, 0, 60)
	}
	
	method getValue()
	{
		return value
	}
}
