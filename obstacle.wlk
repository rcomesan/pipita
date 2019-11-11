import wollok.game.*
import defines.*
import living_object.*

class Obstacle inherits LivingObject
{
	method take()
	{
		self.respawn()
	}
	
	method canWalkInto(_isPlayer, _fromDir)
	{
		if (_isPlayer)
		{
			self.take()
		}
		return _isPlayer
	}
}
