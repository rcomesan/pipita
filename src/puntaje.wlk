import wollok.game.*
import defines.*
import tablero.*
import timer.*
import img.*

class Puntaje inherits Tablero
{
	var position = game.at(FIELD_TILES_WIDTH - 2, FIELD_TILES_HEIGHT - 3)
	var image = "goles.png"
	var gameOverImg = null
	
	method initialize()
	{		
		self.setUp(position.left(1))
		game.addVisual(self)
		self.reset()
	}

	override method reset()
	{
		super()
		if (null != gameOverImg) 
		{
			gameOverImg.destroy()
			gameOverImg = null
		}
	}
	
	method position()
	{
		return position
	}
	
	method image()
	{
		return image		
	}
	
	method incrementar(_cantidad)
	{
		self.setValue(self.getValue() + _cantidad) 		
	}
	
	method showGameOver()
	{
		var imgNumber = 0
		
		if (self.getValue().between(1, 2))
		{
			imgNumber = 1
		}
		if (self.getValue() == 3)
		{
			imgNumber = 2
		}
		else if (self.getValue().between(4, 6))
		{
			imgNumber = 3
		}
		else if (self.getValue().between(7, 10))
		{
			imgNumber = 4
		}
		else if (self.getValue() > 10)
		{
			imgNumber = 5
		}

		gameOverImg = new Img(
			position=game.center().left(1).down(1),
			image="resultado-" + imgNumber.toString() + ".png"
		)
	}
}
