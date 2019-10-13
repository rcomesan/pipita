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
		
	method init(_numPelotas, _numObstaculos)
	{		
		game.onTick(100, "actualizar cancha", { self.update() })
		
		if (arco != null) arco.destroy() 
		arco = new Arco(position=game.at(
			FIELD_TILES_WIDTH * 0.5 - GOAL_TILES_WIDTH * 0.5,
			FIELD_TILES_HEIGHT - GOAL_TILES_HEIGHT
		))
		
		// limpiamos pelotas actuales y respawneamos nuevas
		pelotas.forEach { p => p.destroy() }
		pelotas = []
		numPelotas = if (_numPelotas == 0) BALLS_MAX else _numPelotas
		self.spawnearPelotas(numPelotas)
		
		// limpiamos obstaculos actuales y respawneamos nuevos
		obstaculos.forEach { o => o.destroy() }
		obstaculos = []
		numObstaculos = if (_numObstaculos == 0) OBSTACLES_MAX else _numObstaculos
		self.spawnearObstaculos(numObstaculos)
		
		if (jugador != null) jugador.destroy()
		jugador = new Jugador()

		if (puntaje != null) puntaje.destroy()
		puntaje = new Puntaje()

		if (reloj != null) reloj.destroy()
		reloj = new Reloj(seconds=GAME_DURATION)
		
		activeGame = true
	}
	
	method update()
	{
		if (!activeGame) { return null }
		
		var tmp = []

		if (reloj.timeRemaining() <= 0)
		{
			self.stop()
			puntaje.showGameOver()
		}
		else
		{
			//TODO posible optimizacion acá, reutilizar objetos para evitar allocations/deallocations
			// esto tiene un performance hit bastante significativo, y eso que sólo tenemos como mucho 15 entidades
			// F por wollok
			// F
			// F
			// F

			// borramos pelotas inactivas sin crashear el mainloop de lwjgl
			tmp = pelotas.filter({ p => !p.isAlive() })
			tmp.forEach({ p => p.destroy()})
			pelotas.removeAll(tmp)
			
			// borramos obstáculos inactivos sin crashear el mainloop de lwjgl
			tmp = obstaculos.filter({ o => !o.isAlive() })
			tmp.forEach({ o => o.destroy()})
			obstaculos.removeAll(tmp)
			
			// respawneamos más pelotas y obstaculos si no hay suficientes
			self.spawnearPelotas(numPelotas - pelotas.size())
			self.spawnearObstaculos(numObstaculos - obstaculos.size())
		}
		
		return null		
	}
	
	method stop()
	{
		if (activeGame)
		{
			activeGame = false
			jugador.setEnabled(false)
			
			pelotas.forEach({ p => p.destroy()})
			pelotas = []
	
			obstaculos.forEach({ o => o.destroy()})
			obstaculos = []
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
	
	method getPlayer()
	{
		return jugador
	}
	
	method spawnearPelotas(_cantidad)
	{	
		if (_cantidad > 0)
		{
			new Range(start=1, end=_cantidad).forEach { i =>
				var p = new Pelota(position=general.getRndPos(
					new Position(x=RESPAWN_RANGE_MIN_X, y=RESPAWN_RANGE_MIN_Y), 
					new Position(x=RESPAWN_RANGE_MAX_X, y=RESPAWN_RANGE_MAX_Y)
				))
				p.init(0)
				pelotas.add(p)
			}
		}
	}
	
	method spawnearObstaculos(_cantidad)
	{
		if (_cantidad > 0)
		{
			new Range(start=1, end=_cantidad).forEach { i =>
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
			}
		}
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
			&& self.getPlayer().position() != _pos
			&& null == self.getPelotaAt(_pos)
			&& null == self.getObstaculoAt(_pos)
	}
}