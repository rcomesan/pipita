import wollok.game.*
import defines.*
import cancha.*
import timer.*
import animated_visual.*

class Jugador inherits AnimatedVisual
{
	var animIdle = 0
	
	var enabled = true
	var drunk = false
	
	method initialize()
	{
		self.setUpVisual()
		animIdle = self.addAnimation("jugador", 2)
		self.setAnimation(animIdle)
		
		keyboard.space().onPressDo 	{ self.patear() }
		keyboard.left().onPressDo 	{ self.mover(DIR_WEST) }
		keyboard.right().onPressDo 	{ self.mover(DIR_EAST) }
		keyboard.up().onPressDo 	{ self.mover(DIR_NORTH) }
		keyboard.down().onPressDo 	{ self.mover(DIR_SOUTH) }
		
		self.reset()
	}

	method reset()
	{
		self.setDrunk(false)
		self.setEnabled(true)
		position = game.at((FIELD_TILES_WIDTH - 1) * 0.5, 0)
	}
	
	method isDrunk()
	{
		return drunk
	}

	method setDrunk(_on)
	{
		drunk = _on
		if (drunk)
		{
			game.schedule(DRUNK_EFFECT_DURATION * 1000, { => drunk = false })
		}		
	}
	
	method setEnabled(_on)
	{
		enabled = _on
	}
	
	method patear()
	{
		if (enabled)
		{
			var pelota = cancha.getBallAt(position.up(1))
			if (null != pelota)
			{
				game.sound("patear-pelota.ogg")
				pelota.patear(position)
			}
			else
			{
				game.sound("patear-aire.ogg")
			}
		}
	}
	
	method mover(_dir)
	{
		if (!enabled) return false
				
		var newPosition = game.at(0,0)
		var dir = if (self.isDrunk()) general.getRndInt(1, 4) else _dir

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
		
		if (cancha.isLegalPos(newPosition))
		{
			var obj = cancha.getObjectAt(newPosition)

			if (obj == null || obj.canWalkInto(true, dir))
			{
				position = newPosition
				return true
			}
		}
				
		return false
	}
}

