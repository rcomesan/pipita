import wollok.game.*
import static_visual.*
import defines.*
import field.*

object goal inherits StaticVisual
{
	method initializeObj()
	{
		var p = new Position(
			x=FIELD_TILES_WIDTH * 0.5 - GOAL_TILES_WIDTH * 0.5,
			y= FIELD_TILES_HEIGHT - GOAL_TILES_HEIGHT
		)

		self.setupVisual(p, "arco.png")
	}

	method canScore(_ballPos)
	{
		if (_ballPos.y() >= position.y())
		{
			if (_ballPos.x() == self.getPosPostLeft()
				|| _ballPos.x() == self.getPosPostRight())
			{
				game.sound("palo.ogg")
				return GOAL_RESULT_POSTS	
			}
			else if (_ballPos.x() > self.getPosPostLeft()
				&& _ballPos.x() < self.getPosPostRight()
				&& _ballPos.y() > position.y())
			{
				field.getScore().increment(1)
				game.sound("gol.ogg")		
				return GOAL_RESULT_SCORES
			}	
		}
		return GOAL_RESULT_NOTHING
	}
	
	method getPosPostLeft()
	{
		return position.x()
	}
	
	method getPosPostRight()
	{
		return position.x() + GOAL_TILES_WIDTH - 1
	}
}