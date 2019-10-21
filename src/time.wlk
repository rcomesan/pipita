object time
{
	var timeCounter = 0
	
	method update(_interval)
	{
		timeCounter = timeCounter + (_interval / 1000)
	}
	
	method getCounter() = timeCounter
	method getDelta(_startTime) = (timeCounter - _startTime)
}
