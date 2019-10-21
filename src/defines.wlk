import wollok.game.*

const GAME_DURATION = 30

const TIME_UPDATE_INTERVAL = 100
const AMBIENT_MUSIC_INTERVAL = 115 * 1000

const FIELD_TILES_WIDTH = 21
const FIELD_TILES_HEIGHT = 16

const RESPAWN_RANGE_MIN_X = 1
const RESPAWN_RANGE_MAX_X = (FIELD_TILES_WIDTH - 1) - 1

const RESPAWN_RANGE_MIN_Y = 1
const RESPAWN_RANGE_MAX_Y = (FIELD_TILES_HEIGHT - 1) - 6

const ANIM_SPEED = 4
const GOALKEEPER_REACTION = 250

const BALLS_LIFE_MIN = 4
const BALLS_LIFE_MAX = 9
const BALLS_MAX = 3
const OBSTACLES_MAX = 10

const FOOD_LIFE_MIN = 1
const FOOD_LIFE_MAX = 4

const BEER_LIFE_MIN = 1
const BEER_LIFE_MAX = 3
const DRUNK_EFFECT_DURATION = 4

const TEXTURED_BALL_MIN = 1
const TEXTURED_BALL_MAX = 10

const TEXTURED_NUMBER_MIN = 0
const TEXTURED_NUMBER_MAX = 60

const GOAL_TILES_WIDTH = 13
const GOAL_TILES_HEIGHT = 4

const GOAL_RESULT_NOTHING = -1
const GOAL_RESULT_POSTS = 0
const GOAL_RESULT_SCORES = 1

const OBJECT_TYPE_BALL = 1
const OBJECT_TYPE_OBSTACLE = 2

const KICK_INITIAL_SPEED = 30

const DIR_CENTER = 0
const DIR_NORTH = 1
const DIR_WEST = 2
const DIR_SOUTH = 3
const DIR_EAST = 4

object general
{
	method getRndPos(_minPos, _maxPos)
	{
		var minPos = new Position(
			x=self.clamp(_minPos.x(), 0, FIELD_TILES_WIDTH - 1),
			y=self.clamp(_minPos.y(), 0, FIELD_TILES_HEIGHT - 1))
	
		var maxPos = new Position(
			x=self.clamp((if (_maxPos.x() <= 0) FIELD_TILES_WIDTH - 1 else 0) + _maxPos.x(), 0, FIELD_TILES_WIDTH - 1),
			y=self.clamp((if (_maxPos.y() <= 0) FIELD_TILES_HEIGHT -1 else 0) + _maxPos.y(), 0, FIELD_TILES_HEIGHT - 1))
		
		return new Position(
			x=(new Range(start=minPos.x(), end=maxPos.x())).anyOne(),
			y=(new Range(start=minPos.y(), end=maxPos.y())).anyOne()
		)
	}
	
	method getRnd(_l, _h)
	{
		return _l.randomUpTo(_h)
	}

	method getRndInt(_l, _h)
	{
		return new Range(start=_l, end=_h).anyOne()
	}
	
	method clamp(_a, _min, _max)
	{
		if (_a < _min)
		{
			return _min
		}
		else if (_a > _max)
		{
			return _max
		}
		
		return _a
	}
	
	method mapRange(_v, _fromMin, _fromMax, _toMin, _toMax)
	{
		var v = (_v - _fromMin) / (_fromMax - _fromMin) * (_toMax - _toMin) + _toMin
		return self.clamp(v, _toMin, _toMax)
	}	
}