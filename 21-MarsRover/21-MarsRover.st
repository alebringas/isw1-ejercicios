!classDefinition: #MarsRoverTest category: #'21-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRoverTest methodsFor: 'set up' stamp: 'js 10/6/2019 18:29:58'!
setUp

	north := North newInstance.
	east := East newInstance.
	south := South newInstance.
	west := West newInstance.! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'A.B. 10/6/2019 17:18:56'!
assertRover: aRover isAt: aPosition facing: aDirection

	self assert: aPosition equals: aRover position .
	self assert: aDirection equals: aRover direction.

	! !


!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:08:44'!
test01NoCommandsDontChangePositionNorDirection

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: ''.
	
	self assertRover: rover isAt: 0@0 facing: north.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:17:24'!
test02FacingNorth_OneForward

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'f'.
	
	self assertRover: rover isAt: 0@1  facing: north.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:17:40'!
test03FacingNorth_SeveralForward

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'fff'.
	
	self assertRover: rover isAt: 0@3  facing: north.
	! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:17:46'!
test04FacingNorth_OneBackward

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'b'.
	
	self assertRover: rover isAt: 0@-1  facing: north.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:17:52'!
test05FacingNorth_SeveralBackward

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'bbb'.
	
	self assertRover: rover isAt: 0@-3  facing: north.
	! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:18:18'!
test06FacingNorth_ForwardAndBackward

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'ffb'.
	
	self assertRover: rover isAt: 0@1  facing: north.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/8/2019 19:46:49'!
test07FacingNorth_InvalidCommandMidSequence

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	self 
		should: [ rover do: 'ffbxb' ] 
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: MarsRover invalidCommandErrorDescription equals: anError messageText.
			self assertRover: rover isAt: 0@1 facing: north.
		].
	
	! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:18:55'!
test08FacingSouth_Foward

	| rover |
	rover := MarsRover at: 0@0 facing: south.
	
	rover do: 'f'.
	
	self assertRover: rover isAt: 0@-1  facing: south.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:19:03'!
test09FacingSouth_Backward

	| rover |
	rover := MarsRover at: 0@0 facing: south.
	
	rover do: 'b'.
	
	self assertRover: rover isAt: 0@1  facing: south.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:19:14'!
test10FacingEast_Foward

	| rover |
	rover := MarsRover at: 0@0 facing: east.
	
	rover do: 'f'.
	
	self assertRover: rover isAt: 1@0  facing: east.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:19:22'!
test11FacingEast_Backward

	| rover |
	rover := MarsRover at: 0@0 facing: east.
	
	rover do: 'b'.
	
	self assertRover: rover isAt: -1@0  facing: east.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:19:32'!
test12FacingWest_Forward

	| rover |
	rover := MarsRover at: 0@0 facing: west.
	
	rover do: 'fff'.
	
	self assertRover: rover isAt: -3@0  facing: west.! !

!MarsRoverTest methodsFor: 'moving' stamp: 'js 10/6/2019 18:19:38'!
test13FacingWest_Backward

	| rover |
	rover := MarsRover at: 0@0 facing: west.
	
	rover do: 'bb'.
	
	self assertRover: rover isAt: 2@0  facing: west.! !


!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:20:14'!
test14FacingNorth_TurnRight

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'r'.
	
	self assertRover: rover isAt: 0@0  facing: east.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:20:27'!
test15FacingEast_TurnRight

	| rover |
	rover := MarsRover at: 0@0 facing: east.
	
	rover do: 'r'.
	
	self assertRover: rover isAt: 0@0  facing: south.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:20:41'!
test16FacingSouth_TurnRight

	| rover |
	rover := MarsRover at: 0@0 facing: south.
	
	rover do: 'r'.
	
	self assertRover: rover isAt: 0@0  facing: west.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:20:51'!
test17FacingWest_TurnRight

	| rover |
	rover := MarsRover at: 0@0 facing: west.
	
	rover do: 'r'.
	
	self assertRover: rover isAt: 0@0  facing: north.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:21:10'!
test18FacingNorth_TurnLeft

	| rover |
	rover := MarsRover at: 0@0 facing: north.
	
	rover do: 'l'.
	
	self assertRover: rover isAt: 0@0  facing: west.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:21:23'!
test19FacingEast_TurnLeft

	| rover |
	rover := MarsRover at: 0@0 facing: east.
	
	rover do: 'l'.
	
	self assertRover: rover isAt: 0@0  facing: north.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:21:32'!
test20FacingSouth_TurnLeft

	| rover |
	rover := MarsRover at: 0@0 facing: south.
	
	rover do: 'l'.
	
	self assertRover: rover isAt: 0@0 facing: east.! !

!MarsRoverTest methodsFor: 'turning' stamp: 'js 10/6/2019 18:21:46'!
test21FacingWest_TurnLeft

	| rover |
	rover := MarsRover at: 0@0 facing: west.
	
	rover do: 'l'.
	
	self assertRover: rover isAt: 0@0 facing: south.! !


!classDefinition: #Command category: #'21-MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!Command methodsFor: 'value' stamp: 'A.B. 10/6/2019 19:16:42'!
value: aRover

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: #'21-MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'A.B. 10/6/2019 19:25:00'!
createFor: aCommandID

	^ (self allSubclasses detect: [:subclassCommand | subclassCommand canHandle: aCommandID ]) new.! !


!Command class methodsFor: 'instance creation - private' stamp: 'A.B. 10/6/2019 19:09:53'!
canHandle: aCommandID

	self subclassResponsibility .! !


!classDefinition: #BackwardCommand category: #'21-MarsRover'!
Command subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!BackwardCommand methodsFor: 'value' stamp: 'A.B. 10/6/2019 19:18:09'!
value: aRover
	
	^ aRover moveBackward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: #'21-MarsRover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'instance creation - private' stamp: 'A.B. 10/6/2019 19:09:27'!
canHandle: aCommandID

	^ aCommandID = $b.
	
	! !


!classDefinition: #ForwardCommand category: #'21-MarsRover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!ForwardCommand methodsFor: 'value' stamp: 'A.B. 10/6/2019 19:18:30'!
value: aRover
	
	^ aRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: #'21-MarsRover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'instance creation - private' stamp: 'A.B. 10/6/2019 19:11:27'!
canHandle: aCommandID

	^ aCommandID = $f.! !


!classDefinition: #InvalidCommand category: #'21-MarsRover'!
Command subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!InvalidCommand methodsFor: 'value' stamp: 'js 10/8/2019 19:47:17'!
value: aRover

	^ self error: aRover class invalidCommandErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidCommand class' category: #'21-MarsRover'!
InvalidCommand class
	instanceVariableNames: ''!

!InvalidCommand class methodsFor: 'instance creation - private' stamp: 'js 10/8/2019 19:45:15'!
canHandle: aCommandID

	^ ('fbrl' includes: aCommandID) not.
	! !


!classDefinition: #LeftTurnCommand category: #'21-MarsRover'!
Command subclass: #LeftTurnCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!LeftTurnCommand methodsFor: 'value' stamp: 'A.B. 10/6/2019 19:18:53'!
value: aRover
	
	^ aRover turnLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftTurnCommand class' category: #'21-MarsRover'!
LeftTurnCommand class
	instanceVariableNames: ''!

!LeftTurnCommand class methodsFor: 'instance creation - private' stamp: 'A.B. 10/6/2019 19:11:34'!
canHandle: aCommandID

	^ aCommandID = $l.! !


!classDefinition: #RightTurnCommand category: #'21-MarsRover'!
Command subclass: #RightTurnCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!RightTurnCommand methodsFor: 'value' stamp: 'A.B. 10/6/2019 19:19:06'!
value: aRover
	
	^ aRover turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightTurnCommand class' category: #'21-MarsRover'!
RightTurnCommand class
	instanceVariableNames: ''!

!RightTurnCommand class methodsFor: 'instance creation - private' stamp: 'A.B. 10/6/2019 19:11:39'!
canHandle: aCommandID

	^ aCommandID = $r.! !


!classDefinition: #Direction category: #'21-MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!Direction methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:37'!
backwardDirection: aRover
	
	self subclassResponsibility.! !

!Direction methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:52'!
forwardDirection: aRover
	
	self subclassResponsibility.! !

!Direction methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:12'!
leftDirection: aRover
	
	self subclassResponsibility.! !

!Direction methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:26'!
rightDirection: aRover
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: #'21-MarsRover'!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'instance creation' stamp: 'js 10/6/2019 18:10:52'!
newInstance

	self subclassResponsibility .! !


!classDefinition: #East category: #'21-MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!East methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:37'!
backwardDirection: aRover
	
	aRover moveWest ! !

!East methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:52'!
forwardDirection: aRover
	
	aRover moveEast ! !

!East methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:12'!
leftDirection: aRover

	aRover changeDirection: North newInstance.! !

!East methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:26'!
rightDirection: aRover

	aRover changeDirection: South newInstance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #'21-MarsRover'!
East class
	instanceVariableNames: 'uniqueInstance'!

!East class methodsFor: 'class initialization' stamp: 'js 10/6/2019 18:14:34'!
initialize

	uniqueInstance := self basicNew.! !


!East class methodsFor: 'instance creation' stamp: 'js 10/6/2019 18:12:45'!
newInstance

	^ uniqueInstance.! !


!classDefinition: #North category: #'21-MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!North methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:37'!
backwardDirection: aRover
	
	aRover moveSouth ! !

!North methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:52'!
forwardDirection: aRover
	
	aRover moveNorth! !

!North methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:12'!
leftDirection: aRover

	aRover changeDirection: West newInstance.! !

!North methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:26'!
rightDirection: aRover

	aRover changeDirection: East newInstance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #'21-MarsRover'!
North class
	instanceVariableNames: 'uniqueInstance'!

!North class methodsFor: 'class initialization' stamp: 'js 10/6/2019 18:14:50'!
initialize

	uniqueInstance := self basicNew.! !


!North class methodsFor: 'instance creation' stamp: 'js 10/6/2019 18:13:10'!
newInstance

	^ uniqueInstance.! !


!classDefinition: #South category: #'21-MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!South methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:37'!
backwardDirection: aRover
	
	aRover moveNorth ! !

!South methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:52'!
forwardDirection: aRover
	
	aRover moveSouth! !

!South methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:12'!
leftDirection: aRover

	aRover changeDirection: East newInstance.! !

!South methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:26'!
rightDirection: aRover

	aRover changeDirection: West newInstance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #'21-MarsRover'!
South class
	instanceVariableNames: 'uniqueInstance'!

!South class methodsFor: 'class initialization' stamp: 'js 10/6/2019 18:14:53'!
initialize

	uniqueInstance := self basicNew.! !


!South class methodsFor: 'instance creation' stamp: 'js 10/6/2019 18:13:18'!
newInstance

	^ uniqueInstance.! !


!classDefinition: #West category: #'21-MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!West methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:37'!
backwardDirection: aRover
	
	aRover moveEast ! !

!West methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:20:52'!
forwardDirection: aRover
	
	aRover moveWest! !

!West methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:12'!
leftDirection: aRover

	aRover changeDirection: South newInstance.! !

!West methodsFor: 'direction handling' stamp: 'A.B. 10/6/2019 19:21:26'!
rightDirection: aRover

	aRover changeDirection: North newInstance.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #'21-MarsRover'!
West class
	instanceVariableNames: 'uniqueInstance'!

!West class methodsFor: 'class initialization' stamp: 'js 10/6/2019 18:14:59'!
initialize

	uniqueInstance := self basicNew.! !


!West class methodsFor: 'instance creation' stamp: 'js 10/6/2019 18:13:24'!
newInstance

	^ uniqueInstance.! !


!classDefinition: #MarsRover category: #'21-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRover methodsFor: 'execution' stamp: 'js 10/8/2019 19:47:37'!
do: aCommandSequence 

	aCommandSequence collect: [ :aCommandID | 
		(Command createFor: aCommandID) value: self.
	]
! !


!MarsRover methodsFor: 'position information' stamp: 'A.B. 10/6/2019 15:06:15'!
direction

	^direction! !

!MarsRover methodsFor: 'position information' stamp: 'A.B. 10/6/2019 15:05:15'!
position

	^ position ! !


!MarsRover methodsFor: 'position movements' stamp: 'js 10/6/2019 18:39:02'!
changeDirection: aDirection

	direction := aDirection.! !

!MarsRover methodsFor: 'position movements' stamp: 'js 10/6/2019 18:02:24'!
moveEast
	
	position := (position x + 1)@position y! !

!MarsRover methodsFor: 'position movements' stamp: 'js 10/6/2019 18:01:58'!
moveNorth
	
	position := position x @(position y + 1)! !

!MarsRover methodsFor: 'position movements' stamp: 'js 10/6/2019 18:02:06'!
moveSouth
	
	position := position x @(position y - 1)! !

!MarsRover methodsFor: 'position movements' stamp: 'js 10/6/2019 18:02:49'!
moveWest
	
	position := (position x - 1)@position y! !


!MarsRover methodsFor: 'commands' stamp: 'A.B. 10/6/2019 19:22:24'!
moveBackward

	^ direction backwardDirection: self.! !

!MarsRover methodsFor: 'commands' stamp: 'A.B. 10/6/2019 19:22:14'!
moveForward

	^ direction forwardDirection: self.! !

!MarsRover methodsFor: 'commands' stamp: 'A.B. 10/6/2019 19:21:53'!
turnLeft

	^ direction leftDirection: self.! !

!MarsRover methodsFor: 'commands' stamp: 'A.B. 10/6/2019 19:21:26'!
turnRight

	^ direction rightDirection: self.! !


!MarsRover methodsFor: 'initialization' stamp: 'A.B. 10/6/2019 15:00:52'!
initializeAt: aPosition facing: aDirection 
	
	position := aPosition .
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'21-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'A.B. 10/6/2019 15:05:42'!
at: aPosition facing: aDirection 

	^ self new initializeAt: aPosition facing: aDirection.! !


!MarsRover class methodsFor: 'error messages' stamp: 'js 10/8/2019 19:40:31'!
invalidCommandErrorDescription

	^ 'Invalid command'.! !

East initialize!
North initialize!
South initialize!
West initialize!