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
	
	var numPelotas = BALLS_MAX
	var pelotas = []
	
	var numObstaculos = OBSTACLES_MAX
	var obstaculos = []
	
	method initialize()
	{
		console.println("cancha_initialize")
		game.onTick(1000, "cancha-update", { self.update() })
		
		arco = new Arco(position=game.at(
			FIELD_TILES_WIDTH * 0.5 - GOAL_TILES_WIDTH * 0.5,
			FIELD_TILES_HEIGHT - GOAL_TILES_HEIGHT
		))

		jugador = new Jugador()
		puntaje = new Puntaje()
		reloj = new Reloj(seconds=GAME_DURATION)

		numPelotas.times({ i =>
			var p = new Pelota()
			pelotas.add(p)
		})

		numObstaculos.times({ i =>
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
			obstaculos.add(o)
		})

		console.println("field intialized successfully")
	}
	
	method stop()
	{
		if (activeGame)
		{
			activeGame = false
			jugador.setEnabled(false)
			pelotas.forEach({ p => p.kill() })	
			obstaculos.forEach({ o => o.kill() })
		}
	}

	method newGame()
	{
		activeGame = true
		puntaje.reset()
		reloj.reset()
		jugador.reset()
		pelotas.forEach({ p => p.respawn()})	
		obstaculos.forEach({ o => o.respawn()})
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
				obstaculos.forEach({ o =>
					if (!o.isAlive()) o.respawn()
				})
			}
		}
	}
	
	method getPelotaAt(_pos)
	{
		return pelotas.findOrElse({ p => p.position() ==_pos }, { null })
	}
	
	method getObstaculoAt(_pos)
	{
		return obstaculos.findOrElse({ o => o.position() ==_pos }, { null })
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
			&& null == self.getPelotaAt(_pos)
			&& null == self.getObstaculoAt(_pos)
	}
}