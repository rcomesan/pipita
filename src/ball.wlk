import wollok.game.*
import time.*
import defines.*
import goalkeeper.*
import goal.*
import field.*
import living_object.*

class Ball inherits LivingObject
{
	var kickStartTime = 0
	var kickSpeed = 0
	var img = []
	
	var currentPos = game.at(0, 0)
	var currentImg = 0
	
	method initialize()
	{
		img.add("pelota.png")
		TEXTURED_BALL_MAX.times({ i =>
			img.add("pelota-" + i.toString() + ".png")
		})
		
		self.setup(img.get(0), BALLS_LIFE_MIN, BALLS_LIFE_MAX)
		
		game.onTick(16, "pelota-update", { self.update() })
	}
	
	override method image()
	{
		if (kickStartTime == 0)
		{
			return img.get(currentImg)
		}

		return super()
	}
	
	override method position() 
	{		
		return currentPos
	}
	
	method update()
	{
		currentPos = position

		if (kickStartTime > 0)
		{
			currentPos = new Position(
				x=currentPos.x(),
				y=currentPos.y() + (kickSpeed * (time.getDelta(kickStartTime))).roundUp()
			)
			
			if (currentPos.y() >= (FIELD_TILES_HEIGHT - 1 - GOAL_TILES_HEIGHT))
			{
				if (goalkeeper.canSave(currentPos)
					|| goal.canScore(currentPos) != GOAL_RESULT_NOTHING
					|| !field.isLegalPos(currentPos))
				{
					kickStartTime = 0
					kickSpeed = 0
					
					self.respawn()
				}
			}
		}
		else if (active && !self.isAlive())
		{
			self.respawn()
		}
		
		if (kickStartTime == 0)
		{
			currentImg = general.mapRange(self.getCurrentLife(), 1, self.getTotalLife(), TEXTURED_BALL_MIN, TEXTURED_BALL_MAX).roundUp()
		}
	}

	method canWalkInto(_isPlayer, _fromDir)
	{
		return self.move(_fromDir)
	}
	
	method kick(_posPlayer)
	{
		if (self.position().down(1).equals(_posPlayer))
		{
			kickSpeed = KICK_INITIAL_SPEED
			kickStartTime = time.getCounter()
			return true
		}
		return false
	}
	
	method move(_dir)
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
		
		if (field.isRespawnPos(newPosition))
		{
			var obj = field.getObjectAt(newPosition)
			if (null == obj || obj.canWalkInto(false, _dir))
			{
				position = newPosition
				return true
			}
		}
		
		return false
	}
	
	method isMoving()
	{
		return kickSpeed > 0
	}
}