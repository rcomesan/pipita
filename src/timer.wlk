object timer {
	var time = 0
	
	method update(_interval)
	{
		time = time + (_interval / 1000)
		console.println(time)
	}
	
	method getCounter() = time
	method getDelta(_startTime) = (time - _startTime)
}
