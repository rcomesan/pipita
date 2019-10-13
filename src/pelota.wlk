import wollok.game.*
import timer.*
import defines.*
import cancha.*
import living_object.*

class Pelota inherits LivingObject
{
	var position = game.at(1,1)
		
	var kickTime = 0
	var speed = 0
	
	override method init(_life)
	{
		super(_life)
		game.addVisual(self)
	}

	method destroy()
	{
		game.removeVisual(self)
	}
	
	method image()
	{
		if (self.isAlive())
		{
			if (self.isMoving())
			{
				return "pelota.png"
			}
			else
			{
				return "pelota-" + general.mapRange(self.getLife(), 1, self.totalLife(), TEXTURED_BALL_MIN, TEXTURED_BALL_MAX).roundUp() + ".png"
			}
		}

		return "nada.png"	
	}

	method position() 
	{
		var pos = position

		if (self.isMoving())
		{
			pos = game.at(
				pos.x(),
				pos.y() + speed * (timer.getDelta(kickTime))
			)

			if ((RESULTADO_ARCO_NADA != cancha.getArco().esGol(pos)) || !cancha.isLegalPos(pos))
			{
				kickTime = 0
				speed = 0
				self.kill()
			}		
		}
		
		return pos
	}
	
	method patear(_posJugador)
	{
		if (self.position().down(1).equals(_posJugador))
		{
			speed = KICK_INITIAL_SPEED
			kickTime = timer.getCounter()
			return true
		}
		return false
	}
	
	method mover(_dir)
	{
		var newPosition = game.at(0, 0)

		if (_dir == DIR_WEST)
		{
			newPosition = position.left(1)	
		}
		else if (_dir == DIR_EAST)
		{
			newPosition = position.right(1)
		}
		else if (_dir == DIR_NORTH)
		{
			newPosition = position.up(1)
		}
		else if (_dir == DIR_SOUTH)
		{
			newPosition = position.down(1)	
		}
		else
		{
			return false
		}
		
		if (cancha.isRespawnPos(newPosition))
		{
			var pelota = cancha.getPelotaAt(newPosition)
			var obstaculo = cancha.getObstaculoAt(newPosition)
			if ((null == obstaculo) && (null == pelota || pelota.mover(_dir)))
			{
				position = newPosition
				return true
			}
		}
		
		return false
	}

	method isMoving()
	{
		return kickTime > 0
	}
}