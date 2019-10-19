import wollok.game.*
import timer.*
import defines.*
import cancha.*
import living_object.*

class Pelota inherits LivingObject
{
	var kickStartTime = 0
	var kickSpeed = 0
	var img = []
	
	method initialize()
	{
		img.add("pelota.png")
		TEXTURED_BALL_MAX.times({ i =>
			img.add("pelota-" + i.toString() + ".png")
		})
		
		self.init(img.get(0), BALLS_LIFE_MIN, BALLS_LIFE_MAX)
	}
	
	override method image()
	{
		if (kickStartTime == 0)
		{
			return img.get(general.mapRange(self.getLife(), 1, self.totalLife(), TEXTURED_BALL_MIN, TEXTURED_BALL_MAX).roundUp())
		}

		return super()
	}

	override method position() 
	{
		var pos = position

		if (kickStartTime > 0)
		{
			pos = game.at(
				pos.x(),
				pos.y() + kickSpeed * (timer.getDelta(kickStartTime))
			)

			if ((RESULTADO_ARCO_NADA != cancha.getArco().esGol(pos)) || !cancha.isLegalPos(pos))
			{
				kickStartTime = 0
				kickSpeed = 0
				self.respawn()
			}
		}
		else if (active && !self.isAlive())
		{
			self.respawn()
		}
		
		return pos
	}
	
	method patear(_posJugador)
	{
		if (self.position().down(1).equals(_posJugador))
		{
			kickSpeed = KICK_INITIAL_SPEED
			kickStartTime = timer.getCounter()
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
}