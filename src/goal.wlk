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

	method canSave(_ballPos)
	{
		if (_ballPos.y() >= position.y()
			&& (_ballPos.x() == self.getPosPostLeft() || _ballPos.x() == self.getPosPostRight()))
		{
			game.sound("palo.ogg")
			return true
		}

		return false
	}
	
	method isPosInside(_ballPos)
	{
		return (_ballPos.x() > self.getPosPostLeft()
			&& _ballPos.x() < self.getPosPostRight()
			&& _ballPos.y() > position.y())	
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