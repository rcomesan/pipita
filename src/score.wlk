import wollok.game.*
import defines.*
import numeric_board.*
import static_visual.*

class Score inherits NumericBoard
{
	var gameOverImg = null
	
	override method initialize()
	{		
		self.setup(game.at(FIELD_TILES_WIDTH - 3, FIELD_TILES_HEIGHT - 3), "goles.png", false)	
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

		gameOverImg = new StaticVisual(
			position=game.center().left(1).down(1),
			image="resultado-" + imgNumber.toString() + ".png"
		)
	}
}
