object timer {
	var time = 0
	
	method update(_interval)
	{
		time = time + (_interval / 1000)
	}
	
	method getCounter() = time
	method getDelta(_startTime) = (time - _startTime)
}
