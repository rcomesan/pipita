import wollok.game.*

const TIME_UPDATE_INTERVAL = 100

const GAME_DURATION = 30

const FIELD_TILES_WIDTH = 21
const FIELD_TILES_HEIGHT = 16

const RESPAWN_RANGE_MIN_X = 1
const RESPAWN_RANGE_MAX_X = (FIELD_TILES_WIDTH - 1) - 1

const RESPAWN_RANGE_MIN_Y = 1
const RESPAWN_RANGE_MAX_Y = (FIELD_TILES_HEIGHT - 1) - 6

const ANIM_SPEED = 4

const BALLS_LIFE_MIN = 3
const BALLS_LIFE_MAX = 6
const BALLS_MAX = 3
const OBSTACLES_MAX = 10

const BURGUER_LIFE_MIN = 1
const BURGUER_LIFE_MAX = 4

const BEER_LIFE_MIN = 1
const BEER_LIFE_MAX = 3
const DRUNK_EFFECT_DURATION = 4

const TEXTURED_BALL_MIN = 1
const TEXTURED_BALL_MAX = 10

const TEXTURED_NUMBER_MIN = 0
const TEXTURED_NUMBER_MAX = 60

const GOAL_TILES_WIDTH = 13
const GOAL_TILES_HEIGHT = 4

const RESULTADO_ARCO_NADA = -1
const RESULTADO_ARCO_PALO = 0
const RESULTADO_ARCO_GOL = 1

const KICK_INITIAL_SPEED = 50

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
			x=general.clamp(_minPos.x(), 0, FIELD_TILES_WIDTH - 1),
			y=general.clamp(_minPos.y(), 0, FIELD_TILES_HEIGHT - 1))
	
		var maxPos = new Position(
			x=general.clamp((if (_maxPos.x() <= 0) FIELD_TILES_WIDTH - 1 else 0) + _maxPos.x(), 0, FIELD_TILES_WIDTH - 1),
			y=general.clamp((if (_maxPos.y() <= 0) FIELD_TILES_HEIGHT -1 else 0) + _maxPos.y(), 0, FIELD_TILES_HEIGHT - 1))
		
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