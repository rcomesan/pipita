import wollok.game.*
import defines.*
import pelota.*
import arco.*
import jugador.*
import arquero.*
import timer.*
import score.*
import hamburguesa.*
import papas.*
import pancho.*
import cerveza.*

object cancha
{
	var activeGame = false
	
	var jugador
	var arco
	var arquero
	
	var timer
	var score
	
	var objetos = []
	
	method initialize()
	{
		game.onTick(1000, "cancha-update", { self.update() })
		
		// el orden de instanciacion importa.
		// es la unica forma que tenemos de especificar sorting de visuals
		
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
			else if (n.between(40, 60))
			{
				o = new Hamburguesa()
			}
			else if (n.between(60, 80))
			{
				o = new Pancho()
			}
			else
			{
				o = new Papas()
			}
			
			objetos.add(o)
		})
		
		arquero = new Arquero()
		
		BALLS_MAX.times({ i =>
			var p = new Pelota()
			objetos.add(p)
		})
		
		score = new Score()
		timer = new Timer(seconds=GAME_DURATION)
		jugador = new Jugador()
	}
	
	method endGame()
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
		score.reset()
		timer.reset()
		jugador.reset()
		objetos.forEach({ o => o.respawn()})
	}
	
	method update()
	{
		if (activeGame)
		{
			if (timer.getTimeRemaining() <= 0)
			{
				self.endGame()
				score.showGameOver()
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
	
	method getBalls()
	{
		return objetos.filter({ o => o.getType() == OBJECT_TYPE_BALL })
	}

	method getObjects()
	{
		return objetos
	}
	
	method getObjectAt(_pos)
	{
		return objetos.findOrElse({ o => o.position() ==_pos }, { null })
	}
	
	method getArco()
	{
		return arco
	}
	
	method getTimer()
	{
		return timer
	}
	
	method getScore()
	{
		return score	
	}
	
	method getJugador()
	{
		return jugador
	}

	method getArquero()
	{
		return arquero
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
		return self.getJugador().position() != _pos
			&& null == self.getObjectAt(_pos)
	}
}