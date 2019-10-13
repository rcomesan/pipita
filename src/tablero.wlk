import wollok.game.*
import defines.*

class Tablero
{
	var value = 0
	var texture = null
	
	method b_initialize(_position)
	{
		self.reset()

		texture = object 
		{
			method position() = _position
			method image() = "num-" + value.toString() + ".png"	
		}
		game.addVisual(texture)		
	}
	
	method b_destroy()
	{
		game.removeVisual(texture)
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
