object movementNorth
{
	method move(_pos) { return _pos.up(1) }
}

object movementSouth
{
	method move(_pos) { return _pos.down(1) }
}

object movementWest
{
	method move(_pos) { return _pos.left(1) }	
}

object movementEast
{
	method move(_pos) { return _pos.right(1) }
}
