import defines.*
import timer.*

class LivingObject
{
	var active = true
	var creationTime = 0
	var totalLife = 0
	
	method totalLife() = totalLife
	
	method init(_life)
	{
		totalLife = _life + general.getRnd(-0.5, 0.5)
		if (totalLife <= 0)
		{
			totalLife = general.getRnd(BALLS_LIFE_MIN, BALLS_LIFE_MAX)
		}
		creationTime = timer.getCounter()
	}
	
	method getLife()
	{
		return 0.max(totalLife - timer.getDelta(creationTime))
	}
	
	method isAlive()
	{
		return active && self.getLife() > 0
	}
	
	method kill()
	{
		active = false
	}
}
