import wollok.game.*
import defines.*
import field.*
import animated_visual.*

class Player inherits AnimatedVisual
{
	var animIdle = 0
	var animKicking = 0
	
	var isEnabled = true
	var isDrunk = false
	
	method initialize()
	{
		self.setupVisual()
		animIdle = self.addAnimation("jugador", 2)
		animKicking = self.addAnimation("jugador-pateando", 5)
		self.setAnimation(animIdle, ANIM_SPEED, true)
		
		keyboard.space().onPressDo 	{ self.kick() }
		keyboard.left().onPressDo 	{ self.move(DIR_WEST) }
		keyboard.right().onPressDo 	{ self.move(DIR_EAST) }
		keyboard.up().onPressDo 	{ self.move(DIR_NORTH) }
		keyboard.down().onPressDo 	{ self.move(DIR_SOUTH) }
		
		self.reset()
	}

	method reset()
	{
		self.setDrunk(false)
		self.setEnabled(true)
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, 0)
	}

	method setDrunk(_on)
	{
		isDrunk = _on
		if (isDrunk)
		{
			game.schedule(DRUNK_EFFECT_DURATION * 1000, { => isDrunk = false })
		}		
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
				
		var newPosition = game.at(0,0)
		var dir = if (isDrunk) general.getRndInt(1, 4) else _dir

		if (dir == DIR_WEST)
		{
			newPosition = position.left(1)	
		}
		else if (dir == DIR_EAST)
		{
			newPosition = position.right(1)
		}
		else if (dir == DIR_NORTH)
		{
			newPosition = position.up(1)
		}
		else if (dir == DIR_SOUTH)
		{
			newPosition = position.down(1)	
		}
		else
		{
			return false
		}
		
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

