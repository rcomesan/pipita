import wollok.game.*

class Img
{
	var property image
	var property position
	
	method position() = position
	method image() = image
	
	method initialize()
	{
		game.addVisual(self)	
	}
	
	method destroy()
	{
		game.removeVisual(self)
	}	
}
