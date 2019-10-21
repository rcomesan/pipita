import wollok.game.*

class StaticVisual
{
	var property image = "nada.png"
	var property position = game.at(0, 0)
	var initialized = false
	
	method position() = position
	method image() = image
	
	method initialize()
	{
		self.setupVisual(position, image)
	}
	
	method setupVisual(_position, _image)
	{
		position = _position
		image = _image

		if (!initialized)
		{
			game.addVisual(self)
			initialized = true
		}
	}
	
	method destroy()
	{
		if (initialized)
		{
			game.removeVisual(self)
		}
	}	
}
