starting
restart
	self stop.
	stopRequested := false.
	stopCallbacks := Set new.
	self start