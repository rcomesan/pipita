import wollok.game.*
import defines.*
import living_object.*

class Obstaculo inherits LivingObject
{
	method tomar()
	{
		self.respawn()
	}
}
