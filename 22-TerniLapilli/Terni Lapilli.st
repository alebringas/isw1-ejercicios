!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'board creation' stamp: 'A.B. 10/15/2019 20:03:44'!
newSixPieceGame

	| lapilli |
	lapilli := TerniLapilli new .
	
	lapilli putXAt: 0@0.
	lapilli putOAt: 0@2.
	
	lapilli putXAt: 1@0.
	lapilli putOAt: 0@1.
	
	lapilli putXAt: 2@2.
	lapilli putOAt: 1@1.
	
	^ lapilli .
	! !


!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:10:40'!
test01FirstPlayerIsX
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	self assert: terniLapili isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'A.B. 10/15/2019 20:03:32'!
test02TurnPassesWhenXPlays
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	
	self assert: terniLapili isPlayingO.! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:42:48'!
test03PlayerCanPlayOnlyOnItsTurn
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.

	self should: [ terniLapili putXAt: 0@0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgOutOfTurn equals: anError messageText .
			self assert: terniLapili isPlayingO.	
		].
		! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:43:04'!
test04CanNotPlayInOccupiedPlace
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	
	self should: [ terniLapili putOAt: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgPositionIsOccupied equals: anError messageText .
			self assert: terniLapili isPlayingO.	
		].
! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:45:06'!
test05CannotPlayInInvalidPositionX
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	self should: [ terniLapili putXAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgOutOfBoardPosition equals: anError messageText .
			self assert: terniLapili isPlayingX.	
		].! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:45:06'!
test06CannotPlayInInvalidPositionO
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	terniLapili putXAt: 0@0.

	self should: [ terniLapili putOAt: 4@4. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgOutOfBoardPosition equals: anError messageText .
			self assert: terniLapili isPlayingO.	
		]! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'js 10/15/2019 22:44:18'!
test07ThereAreNoMoreThanSixPiecesOnBoard
	
	| terniLapili |
	
	terniLapili := self newSixPieceGame.

	self should: [ terniLapili putXAt: 1@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgCannotHaveMoreThanSixPieces equals: anError messageText .
			self assert: terniLapili isPlayingX.
			self deny: (terniLapili isOccupied: 1@2).
		]! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'A.B. 10/15/2019 20:03:43'!
test08isOccupiedPositionByX
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	terniLapili putOAt: 0@1.
	
	self assert: (terniLapili isOccupiedByX: 0@0).
	self deny: (terniLapili isOccupiedByX: 0@1).
	self deny: (terniLapili isOccupiedByX: 0@2).

! !

!TerniLapilliTest methodsFor: 'testing - putting' stamp: 'A.B. 10/15/2019 20:03:44'!
test09isOccupiedPositionByO
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	terniLapili putOAt: 0@1.
	
	self deny: (terniLapili isOccupiedByO: 0@0).
	self assert: (terniLapili isOccupiedByO: 0@1).
	self deny: (terniLapili isOccupiedByO: 0@2).

! !


!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'A.B. 10/15/2019 20:03:43'!
test10XWinsByHorizontalLine
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	terniLapili putOAt: 0@2.
	
	terniLapili putXAt: 1@0.
	terniLapili putOAt: 2@1.
	
	terniLapili putXAt: 2@0.
	
	self assert: terniLapili isWinnerX.
	self deny: terniLapili isWinnerO.

! !

!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'A.B. 10/15/2019 20:03:44'!
test11XWinsByVerticalLine
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	terniLapili putOAt: 1@1.
	
	terniLapili putXAt: 0@1.
	terniLapili putOAt: 2@1.
	
	terniLapili putXAt: 0@2.
	
	self assert: terniLapili isWinnerX.
	self deny: terniLapili isWinnerO.

! !

!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'A.B. 10/15/2019 20:03:44'!
test12XWinsByFirstDiagonal
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@0.
	terniLapili putOAt: 0@1.
	
	terniLapili putXAt: 1@1.
	terniLapili putOAt: 2@1.
	
	terniLapili putXAt: 2@2.
	
	self assert: terniLapili isWinnerX.
	self deny: terniLapili isWinnerO.

! !

!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'A.B. 10/15/2019 20:03:43'!
test13XWinsBySecondDiagonal
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 2@0.
	terniLapili putOAt: 0@1.
	
	terniLapili putXAt: 1@1.
	terniLapili putOAt: 2@1.
	
	terniLapili putXAt: 0@2.
	
	self assert: terniLapili isWinnerX.
	self deny: terniLapili isWinnerO.

! !

!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'js 10/15/2019 22:40:50'!
test14CannotPutPieceIfThereIsAWinner
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 2@0.
	terniLapili putOAt: 0@1.
	
	terniLapili putXAt: 1@1.
	terniLapili putOAt: 2@1.
	
	terniLapili putXAt: 0@2.
	
	self should: [ terniLapili putOAt: 0@0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli errorMsgCannotPlayWhenGameIsOver equals: anError messageText .
			self deny: (terniLapili isOccupied: 0@0).
		].
	
! !

!TerniLapilliTest methodsFor: 'testing - winning' stamp: 'A.B. 10/15/2019 20:03:44'!
test15OWinsByPuttingPiece
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@2.
	terniLapili putOAt: 0@0.
	
	terniLapili putXAt: 2@1.
	terniLapili putOAt: 1@0.
	
	terniLapili putXAt: 2@2.
	terniLapili putOAt: 2@0.
	
	self deny: terniLapili isWinnerX.
	self assert: terniLapili isWinnerO.

! !


!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:41:16'!
test16CantSlideWithLessThan6Pieces
	
	| terniLapili |
	
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@2.
	terniLapili putOAt: 0@0.
	
	self should:[terniLapili slideXFrom: 0@2 to: 1@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgCannotSlideWithLessThanSixPieces) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@2).
			self deny: (terniLapili isOccupied: 1@1).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:41:02'!
test17XSlidesAPieceThatIsNotTheirs

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideXFrom: 0@2 to: 1@2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgCannotSlidePieceThatIsNotMyOwn) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@2).
			self deny: (terniLapili isOccupied: 1@2).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:45:06'!
test18XSlidesAPieceToPositionOutOfBounds

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideXFrom: 0@0 to: -1@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgOutOfBoardPosition ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@0).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:43:04'!
test19XSlidesAPieceToOccupiedPosition

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideXFrom: 0@0 to: 1@0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgPositionIsOccupied ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@0).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:42:18'!
test20XSlidesAPieceToTooFarAwayPosition

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideXFrom: 0@0 to: 2@0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgNonContiguousPosition ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@0).
			self deny: (terniLapili isOccupied: 2@0).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:42:30'!
test21XSlidesAPieceToNonLinePosition

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideXFrom: 1@0 to: 2@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgNotInLinePosition ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 1@0).
			self deny: (terniLapili isOccupied: 2@1).
			]! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'A.B. 10/15/2019 20:05:53'!
test22XSlidesAPieceToValidPosition

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	terniLapili slideXFrom: 1@0 to: 2@0.
	self deny: (terniLapili isOccupied: 1@0).
	self assert: (terniLapili isOccupiedByX: 2@0).! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'A.B. 10/15/2019 20:05:53'!
test23OSlidesAPieceToValidPosition

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	terniLapili slideXFrom: 1@0 to: 2@0.
	
	terniLapili slideOFrom: 0@2 to: 1@2.
	
	self deny: (terniLapili isOccupied: 0@2).
	self assert: (terniLapili isOccupiedByO: 1@2).! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:42:48'!
test24OCantSlideIFNotItsTurn

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	
	self should:[terniLapili slideOFrom: 0@2 to: 1@2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgOutOfTurn ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@2).
			self deny: (terniLapili isOccupied: 1@2).
			]
	! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:42:48'!
test25XCantSlideIFNotItsTurn

	| terniLapili |
	
	terniLapili := self newSixPieceGame .
	
	terniLapili slideXFrom: 1@0 to: 2@0.
	
	
	self should:[terniLapili slideXFrom: 2@0 to: 1@0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgOutOfTurn ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 2@0).
			self deny: (terniLapili isOccupied: 1@0).
			]
	! !

!TerniLapilliTest methodsFor: 'testing - sliding' stamp: 'js 10/15/2019 22:40:50'!
test26XCantSlideIFGameOver

	| terniLapili |
		
	terniLapili := TerniLapilli new.
	
	terniLapili putXAt: 0@2.
	terniLapili putOAt: 0@0.
	
	terniLapili putXAt: 2@1.
	terniLapili putOAt: 1@0.
	
	terniLapili putXAt: 2@2.
	terniLapili putOAt: 2@0.
	
	self should:[terniLapili slideXFrom: 0@2 to: 1@2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: (TerniLapilli errorMsgCannotPlayWhenGameIsOver ) equals: anError messageText.
			self assert: (terniLapili isOccupied: 0@2).
			self deny: (terniLapili isOccupied: 1@2).
			]
	! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state isPlayingX positionsOfO positionsOfX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'js 10/15/2019 22:48:15'!
initialize

	isPlayingX := true.
	positionsOfX := OrderedCollection new.
	positionsOfO := OrderedCollection new.
	state := TerniLapilliAddingPiecesState new.! !


!TerniLapilli methodsFor: 'game information' stamp: 'js 10/15/2019 22:48:15'!
isBoardFull
	
	^ positionsOfX size + positionsOfO size = 6.! !

!TerniLapilli methodsFor: 'game information' stamp: 'A.B. 10/14/2019 20:22:20'!
isGameOver
	
	^ (self isWinnerX) or: [ self isWinnerO ].! !

!TerniLapilli methodsFor: 'game information' stamp: 'js 10/10/2019 17:39:57'!
isPlayingO
	
	^ isPlayingX not.! !

!TerniLapilli methodsFor: 'game information' stamp: 'js 10/15/2019 22:01:24'!
isPlayingX
	
	^ isPlayingX.! !

!TerniLapilli methodsFor: 'game information' stamp: 'js 10/15/2019 22:47:59'!
isWinnerO

	^ self areWinningPositions: positionsOfO.! !

!TerniLapilli methodsFor: 'game information' stamp: 'js 10/15/2019 22:48:15'!
isWinnerX

	^ self areWinningPositions: positionsOfX.! !


!TerniLapilli methodsFor: 'player actions' stamp: 'js 10/15/2019 20:50:44'!
doActionAndPassTurn: aPlayerAction
	
	aPlayerAction value.
	isPlayingX := isPlayingX not.	! !

!TerniLapilli methodsFor: 'player actions' stamp: 'js 10/15/2019 22:47:59'!
putOAt: aPosition 

	self isPlayingX ifTrue: [ self error: self class errorMsgOutOfTurn ].
	self putAt: aPosition withPositions: positionsOfO.
	

	
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'js 10/15/2019 22:48:15'!
putXAt: aPosition 

	self isPlayingO ifTrue: [ self error: self class errorMsgOutOfTurn ].
	self putAt: aPosition withPositions: positionsOfX.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'js 10/15/2019 22:47:59'!
slideOFrom: anOriginPosition to: aDestinationPosition 

	self isPlayingX ifTrue: [ self error: self class errorMsgOutOfTurn ].	
	self slideFrom: anOriginPosition to: aDestinationPosition withPositions: positionsOfO.
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'js 10/15/2019 22:48:15'!
slideXFrom: anOriginPosition to: aDestinationPosition 

	self isPlayingO ifTrue: [ self error: self class errorMsgOutOfTurn ].
	self slideFrom: anOriginPosition to: aDestinationPosition withPositions: positionsOfX.! !


!TerniLapilli methodsFor: 'player actions - private' stamp: 'js 10/15/2019 21:02:46'!
putAt: aPosition withPositions: occupiedPositions

	self assertValidPutAt: aPosition.
	state put: [ occupiedPositions add: aPosition ] inGame: self. ! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'js 10/15/2019 20:59:00'!
slideFrom: anOriginPosition to: aDestinationPosition withPositions: occupiedPositions

	self assertValidSlideFrom: anOriginPosition to: aDestinationPosition with: occupiedPositions.
	state slide: [ occupiedPositions replaceAll: anOriginPosition with: aDestinationPosition ] inGame: self.! !


!TerniLapilli methodsFor: 'player actions validation - private' stamp: 'js 10/15/2019 22:45:06'!
assertValidPutAt: aPosition
	
	(self isOutOfBoardPosition: aPosition ) ifTrue: [self error: self class errorMsgOutOfBoardPosition ].
	(self isOccupied: aPosition) ifTrue: [ self error: self class errorMsgPositionIsOccupied ].
! !

!TerniLapilli methodsFor: 'player actions validation - private' stamp: 'js 10/15/2019 22:45:06'!
assertValidSlideFrom: anOriginPosition to: aDestinationPosition with: occupiedPositions

	(occupiedPositions includes: anOriginPosition) ifFalse: [self error: self class errorMsgCannotSlidePieceThatIsNotMyOwn ].
	
	(self isOutOfBoardPosition: aDestinationPosition ) ifTrue: [self error: self class errorMsgOutOfBoardPosition].
	(self isOccupied: aDestinationPosition ) ifTrue: [ self error: self class errorMsgPositionIsOccupied ].
	
	(self areContiguousPositions: anOriginPosition and: aDestinationPosition) ifFalse: [ self error: self class errorMsgNonContiguousPosition].
	(self isOutOfLineMovementFrom: anOriginPosition to: aDestinationPosition) ifTrue: [ self error: self class errorMsgNotInLinePosition ].
! !


!TerniLapilli methodsFor: 'state change' stamp: 'js 10/15/2019 22:04:55'!
changeToGameOverState

	state := TerniLapilliGameOverState new.
	! !

!TerniLapilli methodsFor: 'state change' stamp: 'A.B. 10/15/2019 20:00:48'!
changeToSlidingState

	state := TerniLapilliSlidingState new.
	! !


!TerniLapilli methodsFor: 'position availability' stamp: 'js 10/15/2019 21:07:32'!
isOccupied: aPosition

	^ (self isOccupiedByX: aPosition ) or: [self isOccupiedByO: aPosition ].! !

!TerniLapilli methodsFor: 'position availability' stamp: 'js 10/15/2019 22:47:59'!
isOccupiedByO: aPosition 
	
	^ positionsOfO includes: aPosition.! !

!TerniLapilli methodsFor: 'position availability' stamp: 'js 10/15/2019 22:48:15'!
isOccupiedByX: aPosition

	^ positionsOfX includes: aPosition.! !


!TerniLapilli methodsFor: 'position validation - private' stamp: 'js 10/15/2019 22:08:34'!
areContiguousPositions: aPosition and: otherPosition

	^ (aPosition dist: otherPosition) < 1.5! !

!TerniLapilli methodsFor: 'position validation - private' stamp: 'A.B. 10/14/2019 19:40:22'!
isDiagonalMovementFrom: anOriginPosition to: aDestinationPosition

	^(anOriginPosition dist: aDestinationPosition) > 1.! !

!TerniLapilli methodsFor: 'position validation - private' stamp: 'js 10/15/2019 21:06:39'!
isNotCenterPosition: aPosition
	
	^ 1@1 ~= aPosition .! !

!TerniLapilli methodsFor: 'position validation - private' stamp: 'A.B. 10/14/2019 20:05:34'!
isOutOfBoardPosition: aPosition

	^ ((aPosition x between: 0 and: 2)not)
		 or: [(aPosition y between: 0 and: 2)not]! !

!TerniLapilli methodsFor: 'position validation - private' stamp: 'js 10/15/2019 21:06:18'!
isOutOfLineMovementFrom: anOriginPosition to: aDestinationPosition

	^(self isDiagonalMovementFrom: anOriginPosition to: aDestinationPosition) 
		and: [(self isNotCenterPosition: anOriginPosition) ]
		and: [(self isNotCenterPosition: aDestinationPosition) ].! !


!TerniLapilli methodsFor: 'endgame testing - private' stamp: 'js 10/15/2019 20:54:20'!
areWinningPositions: somePositions

	^ (self hasHorizontalLine: somePositions) 
		or: [self hasVerticalLine: somePositions ] 
		or: [self hasDiagonalLine: somePositions ] .
! !

!TerniLapilli methodsFor: 'endgame testing - private' stamp: 'js 10/14/2019 17:08:58'!
hasDiagonalLine: positions

	| hasFirstDiagonal hasSecondDiagonal |

	hasFirstDiagonal := (positions includes: 0@0) and: [ positions includes: 1@1 ] and: [ positions includes: 2@2 ].
	hasSecondDiagonal := (positions includes: 2@0) and: [ positions includes: 1@1 ] and: [ positions includes: 0@2 ].

	^ hasFirstDiagonal or: [ hasSecondDiagonal ].
	! !

!TerniLapilli methodsFor: 'endgame testing - private' stamp: 'js 10/15/2019 22:03:33'!
hasHorizontalLine: positions

	^ self thereIsLineIn: positions checkingCoordinate: #y.
	


! !

!TerniLapilli methodsFor: 'endgame testing - private' stamp: 'js 10/15/2019 22:03:33'!
hasVerticalLine: positions

	^ self thereIsLineIn: positions checkingCoordinate: #x.
! !

!TerniLapilli methodsFor: 'endgame testing - private' stamp: 'js 10/15/2019 22:04:04'!
thereIsLineIn: positions checkingCoordinate: aPositionCoordinate

	| hasEnoughPieces hasALine |

	hasEnoughPieces := positions size = 3.
	hasALine := (positions allSatisfy: [ :aPosition | (aPositionCoordinate sendTo: aPosition)  = 0 ])
		or: [positions allSatisfy: [ :aPosition | (aPositionCoordinate sendTo: aPosition) = 1 ]]
		or: [positions allSatisfy: [ :aPosition | (aPositionCoordinate sendTo: aPosition) = 2 ]].
		
	^ hasEnoughPieces and: [ hasALine ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:44:18'!
errorMsgCannotHaveMoreThanSixPieces

	^ 'No puede haber mas de seis fichas en juego'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:40:50'!
errorMsgCannotPlayWhenGameIsOver

	^ 'No se puede jugar si el juego terminó'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:41:02'!
errorMsgCannotSlidePieceThatIsNotMyOwn

	^ 'No es una ficha propia que se pieda mover'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:41:16'!
errorMsgCannotSlideWithLessThanSixPieces

	^ 'No se puede deslizar cuando hay menos de seis piezas en el tablero'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:42:17'!
errorMsgNonContiguousPosition

	^ 'Posición no contigua'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:45:44'!
errorMsgNotInLinePosition

	^ 'No se puede mover a esa posición porque no hay camino.'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:45:30'!
errorMsgOutOfBoardPosition

	^ 'No es una posicion del tablero'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:42:48'!
errorMsgOutOfTurn

	^ 'No es su turno'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'js 10/15/2019 22:43:04'!
errorMsgPositionIsOccupied

	^ 'Posicion ocupada'.! !


!classDefinition: #TerniLapilliState category: #'Terni Lapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliState methodsFor: 'player actions' stamp: 'js 10/15/2019 20:42:51'!
put: aPlayerAction inGame: aTerniLapilli
	
	^ self subclassResponsibility .
! !

!TerniLapilliState methodsFor: 'player actions' stamp: 'js 10/15/2019 20:42:57'!
slide: aPlayerAction inGame: aTerniLapilli

	^ self subclassResponsibility .! !


!classDefinition: #TerniLapilliAddingPiecesState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliAddingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliAddingPiecesState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:04:55'!
put: aPlayerAction inGame: aTerniLapilli

	aTerniLapilli doActionAndPassTurn: aPlayerAction.
	
	(aTerniLapilli isGameOver) ifTrue: [ ^ aTerniLapilli changeToGameOverState].
	(aTerniLapilli isBoardFull) ifTrue: [ ^ aTerniLapilli changeToSlidingState].! !

!TerniLapilliAddingPiecesState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:41:16'!
slide: aPlayerAction inGame: aTerniLapilli

	^ self error: aTerniLapilli class errorMsgCannotSlideWithLessThanSixPieces.! !


!classDefinition: #TerniLapilliGameOverState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliGameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:40:50'!
put: aPlayerAction inGame: aTerniLapilli

	^ self error: aTerniLapilli class errorMsgCannotPlayWhenGameIsOver.! !

!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:40:50'!
slide: aPlayerAction inGame: aTerniLapilli

	^ self error: aTerniLapilli class errorMsgCannotPlayWhenGameIsOver.
	! !


!classDefinition: #TerniLapilliSlidingState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliSlidingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliSlidingState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:44:18'!
put: aPlayerAction inGame: aTerniLapilli

	^ self error: aTerniLapilli class errorMsgCannotHaveMoreThanSixPieces.! !

!TerniLapilliSlidingState methodsFor: 'player actions' stamp: 'js 10/15/2019 22:04:55'!
slide: aPlayerAction inGame: aTerniLapilli
	
	aTerniLapilli doActionAndPassTurn: aPlayerAction.
	
	(aTerniLapilli isGameOver ) ifTrue: [ ^ aTerniLapilli changeToGameOverState].
	! !
