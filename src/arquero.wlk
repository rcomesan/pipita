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
		self.setAnimation(animIdle)
		self.reset()
	}

	method reset()
	{
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, cancha.getArco().position().y() - 1)
	}
	
	method atajar(_posPelota)
	{
		if (_posPelota.x() == position.x()
			&& _posPelota.y().between(position.y(), position.y() + 1))
		{
			game.sound("patear-pelota.ogg")
			self.setAnimation(animAtaja)
			return true
		}
		
		return false
	}
	
	method update()
	{
		var playerPosX = general.clamp(cancha.getJugador().position().x(),
			cancha.getArco().getPosPaloIzq() + 1,
			cancha.getArco().getPosPaloDer() - 1
		)
		
		if (position.x() > playerPosX)
		{
			self.setAnimation(animIdle)
			position = position.left(1)
		}
		else if (position.x() < playerPosX)
		{
			self.setAnimation(animIdle)
			position = position.right(1)
		}
	}
}
