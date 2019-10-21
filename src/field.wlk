import wollok.game.*
import defines.*
import ball.*
import goal.*
import player.*
import goalkeeper.*
import timer.*
import score.*
import burguer.*
import french_fries.*
import hot_dog.*
import beer.*

object field
{
	var activeGame = false
	
	var player
	var goal
	var goalkeeper
	
	var timer
	var score
	
	var objects = []
	
	method initialize()
	{
		game.onTick(1000, "Goalkeeper-update", { self.update() })
				
		goal = new Goal()

		OBSTACLES_MAX.times({ i =>
			var n = general.getRndInt(1, 100)
			var o = null

			if (n.between(1, 40))
			{
				o = new Beer()
			}
			else if (n.between(40, 60))
			{
				o = new Burguer()
			}
			else if (n.between(60, 80))
			{
				o = new HotDog()
			}
			else
			{
				o = new FrenchFries()
			}
			
			objects.add(o)
		})
		
		goalkeeper = new Goalkeeper()
		
		BALLS_MAX.times({ i =>
			var b = new Ball()
			objects.add(b)
		})
		
		score = new Score()
		timer = new Timer(seconds=GAME_DURATION)
		player = new Player()
	}
	
	method endGame()
	{
		if (activeGame)
		{
			activeGame = false
			player.setEnabled(false)
			objects.forEach({ o => o.kill() })
		}
	}

	method newGame()
	{
		activeGame = true
		score.reset()
		timer.reset()
		player.reset()
		objects.forEach({ o => o.respawn()})
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
				objects.forEach({ o =>
					if (!o.isAlive()) o.respawn()
				})
			}
		}
	}
	
	method getBallAt(_pos)
	{
		return objects.findOrElse({ o => o.position() ==_pos && o.getType() == OBJECT_TYPE_BALL }, { null })
	}
	
	method getBalls()
	{
		return objects.filter({ o => o.getType() == OBJECT_TYPE_BALL })
	}

	method getObjects()
	{
		return objects
	}
	
	method getObjectAt(_pos)
	{
		return objects.findOrElse({ o => o.position() ==_pos }, { null })
	}
	
	method getGoal()
	{
		return goal
	}
	
	method getTimer()
	{
		return timer
	}
	
	method getScore()
	{
		return score	
	}
	
	method getPlayer()
	{
		return player
	}

	method getGoalkeeper()
	{
		return goalkeeper
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
		return self.getPlayer().position() != _pos
			&& null == self.getObjectAt(_pos)
	}
}