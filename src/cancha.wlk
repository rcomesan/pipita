import wollok.game.*
import defines.*
import pelota.*
import arco.*
import jugador.*
import reloj.*
import puntaje.*
import hamburguesa.*
import cerveza.*

object cancha
{
	var activeGame = false
	
	var jugador
	var arco
	
	var reloj
	var puntaje
	
	var objetos = []
	
	method initialize()
	{
		game.onTick(1000, "cancha-update", { self.update() })
		
		arco = new Arco(position=game.at(
			FIELD_TILES_WIDTH * 0.5 - GOAL_TILES_WIDTH * 0.5,
			FIELD_TILES_HEIGHT - GOAL_TILES_HEIGHT
		))

		OBSTACLES_MAX.times({ i =>
			var n = general.getRndInt(1, 100)
			var o = null

			if (n.between(1, 40))
			{
				o = new Cerveza()
			}
			else
			{
				o = new Hamburguesa()
			}
			objetos.add(o)
		})
		BALLS_MAX.times({ i =>
			var p = new Pelota()
			objetos.add(p)
		})
		
		puntaje = new Puntaje()
		reloj = new Reloj(seconds=GAME_DURATION)
		jugador = new Jugador()
	}
	
	method stop()
	{
		if (activeGame)
		{
			activeGame = false
			jugador.setEnabled(false)
			objetos.forEach({ o => o.kill() })
		}
	}

	method newGame()
	{
		activeGame = true
		puntaje.reset()
		reloj.reset()
		jugador.reset()
		objetos.forEach({ o => o.respawn()})
	}
	
	method update()
	{
		if (activeGame)
		{
			if (reloj.timeRemaining() <= 0)
			{
				self.stop()
				puntaje.showGameOver()
			}
			else
			{
				objetos.forEach({ o =>
					if (!o.isAlive()) o.respawn()
				})
			}
		}
	}
	
	method getBallAt(_pos)
	{
		return objetos.findOrElse({ o => o.position() ==_pos && o.getType() == OBJECT_TYPE_BALL }, { null })
	}
	
	method getObjectAt(_pos)
	{
		return objetos.findOrElse({ o => o.position() ==_pos }, { null })
	}
	
	method getArco()
	{
		return arco
	}
	
	method getReloj()
	{
		return reloj
	}
	
	method getPuntaje()
	{
		return puntaje	
	}
	
	method getJugador()
	{
		return jugador
	}

	method isRespawnPos(_pos)
	{
		return _pos.x() >= RESPAWN_RANGE_MIN_X 
			&& _pos.y() >= RESPAWN_RANGE_MIN_Y 
			&& _pos.x() <= RESPAWN_RANGE_MAX_X 
			&& _pos.y() <= RESPAWN_RANGE_MAX_Y
	}
	
	method isLegalPos(_pos)
	{
		return _pos.x() >= 0
			&& _pos.y() >= 0
			&& _pos.x() <= FIELD_TILES_WIDTH - 1
			&& _pos.y() <= FIELD_TILES_HEIGHT - 1
	}
	
	method isEmptyPos(_pos)
	{
		return true
			&& self.getJugador().position() != _pos
			&& null == self.getObjectAt(_pos)
	}
}