import wollok.game.*
import defines.*
import living_object.*

class Obstaculo inherits LivingObject
{
	method tomar()
	{
		self.respawn()
	}
	
	method canWalkInto(_isPlayer, _fromDir)
	{
		if (_isPlayer)
		{
			self.tomar()
		}
		return _isPlayer
	}
	
	method getType()
	{
		return OBJECT_TYPE_OBSTACLE
	}
}
