import wollok.game.*
import defines.*
import field.*
import time.*
import animated_visual.*

class Goalkeeper inherits AnimatedVisual
{
	var animIdle = 0
	var animSave = 0
	
	method initialize()
	{
		game.onTick(GOALKEEPER_REACTION, "goalkeeper-update", { self.update() })
		
		self.setupVisual()
		
		animIdle = self.addAnimation("arquero", 2)
		animSave = self.addAnimation("arquero-ataja", 1)
		self.setAnimation(animIdle, ANIM_SPEED, true)

		self.reset()
	}

	method reset()
	{
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, field.getGoal().position().y())
	}
	
	method canSave(_ballPos)
	{
		if (_ballPos.x() == position.x()
			&& _ballPos.y().between(position.y() - 1, position.y()))
		{
			game.sound("patear-pelota.ogg")
			self.setAnimation(animSave, ANIM_SPEED, true)
			return true
		}
		
		return false
	}
	
	method update()
	{
		var targetPosX = 0
		
		var ballsMoving = field.getObjects().filter({ o => o.getType() == OBJECT_TYPE_BALL && o.isMoving() })
		if (ballsMoving.size() > 0)
		{
			targetPosX = ballsMoving.first().position().x()
		}
		else
		{
	 		targetPosX = field.getPlayer().position().x()
		}
		
		targetPosX = general.clamp(targetPosX,
				field.getGoal().getPosPostLeft() + 1,
				field.getGoal().getPosPostRight() - 1)
		
		if (position.x() > targetPosX)
		{
			self.setAnimation(animIdle, ANIM_SPEED, true)
			position = position.left(1)
		}
		else if (position.x() < targetPosX)
		{
			self.setAnimation(animIdle, ANIM_SPEED, true)
			position = position.right(1)
		}
	}
}
