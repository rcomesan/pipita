import wollok.game.*
import defines.*
import ball.*
import goal.*
import player.*
import goalkeeper.*
import timer.*
import score.*
import food.*
import beer.*

object field
{
	const obstaclesMax = 10
	const ballsMax = 3
	
	var activeGame = false
	
	var player
	var goal
	var goalkeeper
	
	var timer
	var score
	
	var obstacles = []
	var balls = []
	
	method initialize()
	{
		game.onTick(1000, "Goalkeeper-update", { self.update() })
		
		goal = new Goal()
		self.placeObstacles()
		goalkeeper = new Goalkeeper()
		self.placeBalls()
		
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
			self.getObjects().forEach({ o => o.kill() })
		}
	}

	method newGame()
	{
		activeGame = true
		score.reset()
		timer.reset()
		player.reset()
		self.getObjects().forEach({ o => o.respawn()})
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
				self.getObjects().forEach({ o =>
					if (!o.isAlive()) o.respawn()
				})
			}
		}
	}
	
	method getBallAt(_pos)
	{
		return balls.findOrElse({ o => o.position() ==_pos }, { null })
	}
	
	method getBalls()
	{
		return balls
	}

	method getObjects()
	{
		return obstacles + balls;
	}
	
	method getObjectAt(_pos)
	{
		return self.getObjects().findOrElse({ o => o.position() ==_pos }, { null })
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
	
	method generateObstacle()
	{
		var prob = 1.randomUpTo(100)
		return 
			if (prob < 40) new Beer()
			else if (prob < 60) new Food(foodType = burguer)
			else if (prob < 80) new Food(foodType = hotDog)
			else new Food(foodType = frenchFries)
	}

	method placeObstacles()
	{
		obstaclesMax.times({ i => obstacles.add(self.generateObstacle()) })
	}
	
	method placeBalls()
	{
		ballsMax.times({ i => balls.add(new Ball()) })
	}
}