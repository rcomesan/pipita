import wollok.game.*
import defines.*
import cancha.*
import timer.*

class Jugador
{
	var property position = game.at((FIELD_TILES_WIDTH -1) * 0.5,0)
	var enabled = true
	var drunk = false
	
	method position() = position

	method image()
	{
		return "jugador-" + ((timer.getCounter() * ANIM_SPEED).truncate(0) % 2) + ".png"
	}
	
	method initialize()
	{
		game.addVisual(self)
		game.errorReporter(self)
		
		keyboard.space().onPressDo 	{ self.patear() }
		keyboard.left().onPressDo 	{ self.mover(DIR_WEST) }
		keyboard.right().onPressDo 	{ self.mover(DIR_EAST) }
		keyboard.up().onPressDo 	{ self.mover(DIR_NORTH) }
		keyboard.down().onPressDo 	{ self.mover(DIR_SOUTH) }
	}

	method destroy()
	{
		game.removeVisual(self)
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
			var pelota = cancha.getPelotaAt(position.up(1))
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
		
		var pelota = cancha.getPelotaAt(newPosition)
		var obstaculo = cancha.getObstaculoAt(newPosition)
		
		var puedeMover = true  
			&& cancha.isLegalPos(newPosition)
			&& null == pelota 
		
		if (null != pelota)
		{
			// tratamos de acomodamos la pelota
			puedeMover = pelota.mover(dir)
		}
		
		if (null != obstaculo)
		{
			// pisamos el obstáculo
			obstaculo.tomar()
		}
		
		if (puedeMover)
		{
			position = newPosition
			return true
		}
		
		return false
	}
}

