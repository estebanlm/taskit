testing
isRunning
	^ taskExecution ifNotNil: [ taskExecution isRunning ] ifNil: [ false ]