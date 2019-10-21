import wollok.game.*
import defines.*
import static_visual.*

class NumericBoard inherits StaticVisual
{
	var value = 0
	var numTexture = null
	
	method setup(_position, _label, _leftAligned)
	{
		self.reset()
		var numPos

		if (_leftAligned)
		{
			self.setupVisual(_position, _label)
			numPos = _position.right(1)
		}
		else
		{
			self.setupVisual(_position.right(1), _label)
			numPos = _position
		}

		numTexture = object 
		{
			var img = []
			
			method initialize()
			{
				61.times({ i =>
					img.add("num-" + (i - 1) + ".png")
				})
			}
			
			method position() = numPos
			method image() = img.get(value)	
		}
		game.addVisual(numTexture)		
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
