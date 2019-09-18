!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'js 9/17/2019 22:48:19'!
test01FinderShouldRaiseErrorOnEmptyPrefix

	| sentenceFinder aSentenceStack |
	
	aSentenceStack := OOStack new.	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self should: [ sentenceFinder find: '' inStack: aSentenceStack ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ].
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'js 9/17/2019 22:44:45'!
test02FinderShouldntFindSentenceWithEmptyStack

	| sentenceFinder aSentenceStack |
	
	aSentenceStack := OOStack new.
	aSentenceStack push: 'winter is coming'.
	aSentenceStack push: 'The winds of Winter'.
	aSentenceStack push: 'Winter is here'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'unaOracion' inStack: aSentenceStack) isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'js 9/17/2019 21:38:38'!
test03FinderShouldntFindSentence

	| sentenceFinder aSentenceStack |
	
	aSentenceStack := OOStack new.
	aSentenceStack push: 'winter is coming'.
	aSentenceStack push: 'The winds of Winter'.
	aSentenceStack push: 'Winter is here'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'summer' inStack: aSentenceStack) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'B 9/18/2019 14:53:56'!
test04FinderShouldFindOneSentence

	| sentenceFinder aSentenceStack foundSentences |
	
	aSentenceStack := OOStack new.
	aSentenceStack push: 'winter is coming'.
	aSentenceStack push: 'The winds of Winter'.
	aSentenceStack push: 'Winter is here'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	foundSentences := sentenceFinder find: 'Wint' inStack: aSentenceStack.
	
	self assert: foundSentences size = 1.
	self assert: foundSentences includes: 'Winter is here'.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'js 9/17/2019 22:23:54'!
test05FinderShouldFindSeveralSentences

	| sentenceFinder aSentenceStack foundSentences expectedSentences |
	
	aSentenceStack := OOStack new.
	aSentenceStack push: 'winter is coming'.
	aSentenceStack push: 'The winds of Winter'.
	aSentenceStack push: 'Winter is here'.
	aSentenceStack push: 'Winter is here it is very cold'.
	aSentenceStack push: 'Winter is here finally'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	expectedSentences := Set new.
	expectedSentences add: 'Winter is here'.
	expectedSentences add: 'Winter is here it is very cold'.
	expectedSentences add: 'Winter is here finally'.	
	
	foundSentences := sentenceFinder find: 'Wint' inStack: aSentenceStack.
	
	self assert: foundSentences size = 3.
	self assert: expectedSentences = (Set newFrom: foundSentences).
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'js 9/17/2019 22:49:16'!
test06FinderShouldRaiseErrorOnPrefixWithSpaces

	| sentenceFinder aSentenceStack |
	
	aSentenceStack := OOStack new.	
	sentenceFinder := SentenceFinderByPrefix new.
	
	self should: [ sentenceFinder find: 'una oracion con espacios' inStack: aSentenceStack ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ].
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'b 9/16/2019 19:27:04'!
initialize

	elements := OrderedCollection new! !


!OOStack methodsFor: 'modification' stamp: 'B 9/17/2019 20:01:46'!
pop

	| stackState |
	
	stackState _ StackState obtainStateOfStack: self.

	^ stackState popFromStack: self.! !

!OOStack methodsFor: 'modification' stamp: 'B 9/17/2019 19:40:16'!
popFromEmptyStack

	^ self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'modification' stamp: 'B 9/17/2019 19:56:54'!
popFromNotEmptyStack

	^ elements removeLast.! !

!OOStack methodsFor: 'modification' stamp: 'b 9/16/2019 19:27:04'!
push: anElement

	elements addLast: anElement.! !


!OOStack methodsFor: 'information' stamp: 'b 9/16/2019 19:27:04'!
isEmpty

	^ elements isEmpty! !

!OOStack methodsFor: 'information' stamp: 'b 9/16/2019 19:28:09'!
size

	^ elements size.! !

!OOStack methodsFor: 'information' stamp: 'B 9/17/2019 20:01:39'!
top

	| stackState |
	
	stackState _ StackState obtainStateOfStack: self.

	^ stackState topFromStack: self.
! !

!OOStack methodsFor: 'information' stamp: 'B 9/17/2019 19:44:00'!
topFromEmptyStack
	
	^ self error: self class stackEmptyErrorDescription.
! !

!OOStack methodsFor: 'information' stamp: 'B 9/17/2019 19:57:08'!
topFromNotEmptyStack

	^ elements last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'js 9/17/2019 22:42:51'!
isInvalidPrefix: aPrefix
	
	^ aPrefix isEmpty or: (aPrefix includesSubString: ' ').
! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'js 9/18/2019 19:04:25'!
find: aPrefix inStack: aSentenceStack
	
	(self isInvalidPrefix: aPrefix) 
		ifTrue: [ self error: self class invalidPrefixErrorDescription ].
	
	^ stackSelector selectFrom: aSentenceStack withCondition: [ :aSentence | aSentence beginsWith: aPrefix ].	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'B 9/18/2019 15:19:35'!
initialize

	stackSelector := StackSelector new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'js 9/17/2019 22:46:33'!
invalidPrefixErrorDescription
	
	^ 'Prefix cannot be empty nor contain spaces.'! !


!classDefinition: #StackSelector category: #'Stack-Exercise'!
Object subclass: #StackSelector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackSelector methodsFor: 'selecting elements' stamp: 'js 9/18/2019 19:17:12'!
moveFrom: anOriginStack to: aDestinationStack
			
	self moveFrom: anOriginStack to: aDestinationStack doingForEachElement: [ :anElement | ].! !

!StackSelector methodsFor: 'selecting elements' stamp: 'js 9/18/2019 19:11:44'!
moveFrom: anOriginStack to: aDestinationStack doingForEachElement: aClosure

	[ anOriginStack isEmpty ] whileFalse: [ 
			| anElement | 
			anElement := anOriginStack pop. 
			aClosure value: anElement. 
			aDestinationStack push: anElement. ].  ! !

!StackSelector methodsFor: 'selecting elements' stamp: 'js 9/18/2019 19:18:43'!
selectFrom: aStack withCondition: aCondition

	|selectionStack selectedElements|
	
	selectionStack := OOStack  new.
	selectedElements := Set new.
	
	self moveFrom: aStack to: selectionStack  
		doingForEachElement: [:anElement| (aCondition value: anElement ) ifTrue: [selectedElements add: anElement ] ].
	
	self moveFrom: selectionStack to: aStack. 
			
	^ selectedElements.  ! !


!classDefinition: #StackState category: #'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:54:49'!
popFromStack: aStack

	^ self subclassResponsibility .! !

!StackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:58:47'!
topFromStack: aStack

	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackState class' category: #'Stack-Exercise'!
StackState class
	instanceVariableNames: ''!

!StackState class methodsFor: 'instance creation' stamp: 'B 9/17/2019 20:08:10'!
obtainStateOfStack: aStack
	
	| representingStackStateClass |

	representingStackStateClass _ self subclasses detect: [ :aStackStateClass | aStackStateClass representsStack: aStack ].
	
	^ representingStackStateClass new.! !


!classDefinition: #EmptyStackState category: #'Stack-Exercise'!
StackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:54:49'!
popFromStack: aStack

	^ aStack popFromEmptyStack.! !

!EmptyStackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:57:43'!
topFromStack: aStack

	^ aStack topFromEmptyStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStackState class' category: #'Stack-Exercise'!
EmptyStackState class
	instanceVariableNames: ''!

!EmptyStackState class methodsFor: 'representativity' stamp: 'B 9/17/2019 20:04:57'!
representsStack: aStack

	^ aStack isEmpty.! !


!classDefinition: #NotEmptyStackState category: #'Stack-Exercise'!
StackState subclass: #NotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:56:54'!
popFromStack: aStack

	^ aStack popFromNotEmptyStack.! !

!NotEmptyStackState methodsFor: 'stack interaction' stamp: 'B 9/17/2019 19:57:43'!
topFromStack: aStack

	^ aStack topFromNotEmptyStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStackState class' category: #'Stack-Exercise'!
NotEmptyStackState class
	instanceVariableNames: ''!

!NotEmptyStackState class methodsFor: 'representativity' stamp: 'B 9/17/2019 20:06:16'!
representsStack: aStack

	^ aStack isEmpty not.! !
