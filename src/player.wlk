import wollok.game.*
import defines.*
import field.*
import animated_visual.*
import movement.*

object drunk
{
	const movements = [movementNorth, movementSouth, movementEast, movementWest]

	method modifyDirection(_dir) = movements.anyOne()
}

object sober
{
	method modifyDirection(_dir) = _dir
}

object player inherits AnimatedVisual
{
	var animIdle = 0
	var animKicking = 0
	
	var isEnabled = true
	var state
	
	method initializeObj()
	{
		self.setupVisual()
		animIdle = self.addAnimation("jugador", 2)
		animKicking = self.addAnimation("jugador-pateando", 5)
		self.setAnimation(animIdle, ANIM_SPEED, true)
		
		keyboard.space().onPressDo 	{ self.kick() }
		keyboard.left().onPressDo 	{ self.move(movementWest) }
		keyboard.right().onPressDo 	{ self.move(movementEast) }
		keyboard.up().onPressDo 	{ self.move(movementNorth) }
		keyboard.down().onPressDo 	{ self.move(movementSouth) }
		
		self.reset()
	}

	method reset()
	{
		state = sober
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, 0)

		self.setEnabled(true)
	}

	method setDrunk()
	{
		state = drunk
		game.schedule(DRUNK_EFFECT_DURATION * 1000, { => self.setSober() })		
	}
	
	method setSober()
	{
		state = sober
	}
	
	method setEnabled(_on)
	{
		isEnabled = _on
	}
	
	method kick()
	{
		if (isEnabled)
		{
			self.setAnimation(animKicking, ANIM_SPEED * 5, false)
		
			var ball = field.getBallAt(position.up(1))
			if (null != ball)
			{
				game.sound("patear-pelota.ogg")
				ball.kick(position)
			}
			else
			{
				game.sound("patear-aire.ogg")
			}
		}
	}
	
	method move(_dir)
	{
		if (!isEnabled) return false

		var dir = state.modifyDirection(_dir)
		var newPosition = dir.move(position)
		
		if (field.isLegalPos(newPosition))
		{
			var obj = field.getObjectAt(newPosition)

			if (obj == null || obj.canWalkInto(true, dir))
			{
				position = newPosition
				return true
			}
		}
				
		return false
	}
}

