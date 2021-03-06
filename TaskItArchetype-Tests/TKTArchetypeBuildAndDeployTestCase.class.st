Class {
	#name : #TKTArchetypeBuildAndDeployTestCase,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'archetype',
		'deployer',
		'session'
	],
	#category : #'TaskItArchetype-Tests'
}

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase class >> testParameters [
	^ ParametrizedTestMatrix new
		forSelector: #archetype addOptions: {TKTArchetype pharoCurrent};
		yourself
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> archetype: anArchetype [
	archetype := anArchetype 
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> runCaseManaged [ 
	^ self runCase
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> setUp [
	super setUp.
	session := Smalltalk session.
	deployer := TKTFileOrientedDeployer default.
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> tearDown [
	session = Smalltalk session
		ifTrue: [ (TKTSystem rm
				option: '-rf';
				argument: (#/ asFileReference / #tmp / archetype name) fullName;
				future) synchronizeTimeout: 1 minute.
			(TKTSystem rm
				option: '-rf';
				argument: ('pharo-local' asFileReference / #forking) fullName;
				future) synchronizeTimeout: 1 minute ]
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> testCommunicationStonHasNoDependancies [
	self assert: archetype dependancies size equals: 0
]

{ #category : #tests }
TKTArchetypeBuildAndDeployTestCase >> testDeployDeploysAFunctionalEnvironment [
	| deployed |
	deployed := deployer deployAtDefaultLocation: archetype.
	self assert: deployed vmFolder exists.
	self assert: deployed imageFile exists.
	self assert: deployed changesFile exists.
	self assert: deployed sourcesFile exists
]
