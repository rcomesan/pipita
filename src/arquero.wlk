import wollok.game.*
import defines.*
import cancha.*
import timer.*
import animated_visual.*

class Arquero inherits AnimatedVisual
{
	var animIdle = 0
	var animAtaja = 0
	
	method initialize()
	{
		game.onTick(GOALKEEPER_REACTION, "arquero-update", { self.update() })
		
		self.setUpVisual()
		animIdle = self.addAnimation("arquero", 2)
		animAtaja = self.addAnimation("arquero-ataja", 1)
		self.setAnimation(animIdle, ANIM_SPEED, true)
		self.reset()
	}

	method reset()
	{
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, cancha.getArco().position().y())
	}
	
	method atajar(_posPelota)
	{
		if (_posPelota.x() == position.x()
			&& _posPelota.y().between(position.y() - 1, position.y()))
		{
			game.sound("patear-pelota.ogg")
			self.setAnimation(animAtaja, ANIM_SPEED, true)
			return true
		}
		
		return false
	}
	
	method update()
	{
		var targetPosX = 0
		
		var ballsMoving = cancha.getObjects().filter({ o => o.getType() == OBJECT_TYPE_BALL && o.isMoving() })
		if (ballsMoving.size() > 0)
		{
			targetPosX = ballsMoving.first().position().x()
		}
		else
		{
	 		targetPosX = cancha.getJugador().position().x()
		}
		
		targetPosX = general.clamp(targetPosX,
				cancha.getArco().getPosPaloIzq() + 1,
				cancha.getArco().getPosPaloDer() - 1)
		
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
