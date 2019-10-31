!classDefinition: #CartTest category: #TusLibros stamp: 'A.B. 10/31/2019 09:29:03'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:29:47'!
test01NewCartIsEmpty

	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:51:29'!
test02CartWithABookIsNotEmpty

	| cart |
	cart := Cart new.
	
	cart add: 0001 withAmount: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:49:01'!
test03CartWithABookHasTheBook

	| cart anISBN |
	cart := Cart new.
	
	anISBN := 0001.
	cart add: anISBN withAmount: 1.
	
	self assert: (cart contains: anISBN).! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:35:54'!
test04EmptyCartDoesNotContainBook

	| cart anISBN |
	cart := Cart new.
	
	anISBN := 0001.
	
	self deny: (cart contains: anISBN).! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:48:35'!
test05AddingZeroBooksToCartRaisesError

	| cart anISBN |
	cart := Cart new.
	
	anISBN := 0001.
	
	self should: [ cart add: anISBN withAmount: 0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart errorMessageAmountZero equals: anError messageText.
			self assert: cart isEmpty.
		].
	! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:49:43'!
test06AddingNegativeAmountOfBooksToCartRaisesError

	| cart anISBN |
	cart := Cart new.
	
	anISBN := 0001.
	
	self should: [ cart add: anISBN withAmount: -1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart errorMessageAmountNegative equals: anError messageText.
			self assert: cart isEmpty.
		].
	! !

!CartTest methodsFor: 'testing' stamp: 'js 10/29/2019 20:56:55'!
test07BookAmountOfACartHasCorrectAmount

	| cart aBook1 aBook2 |
	cart := Cart new.
	
	aBook1 := 0001.
	aBook2 := 0002.

	cart add: aBook1 withAmount: 3.
	cart add: aBook2 withAmount: 1.
	
	self assert: 3 equals: (cart amountOf: aBook1).
	self assert: 1 equals: (cart amountOf: aBook2).
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'A.B. 10/31/2019 09:29:03'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'js 10/29/2019 20:58:58'!
add: aBook withAmount: anAmount

	(anAmount = 0) ifTrue: [ self error: self class errorMessageAmountZero ].
	(anAmount < 0) ifTrue: [ self error: self class errorMessageAmountNegative ].
	
	anAmount timesRepeat: [ books add: aBook ].
! !


!Cart methodsFor: 'initialization' stamp: 'js 10/29/2019 20:36:44'!
initialize
	
	books := OrderedCollection new.
	empty := true.! !


!Cart methodsFor: 'information' stamp: 'js 10/29/2019 20:58:12'!
amountOf: aBook

	^ books count: [:anElement | anElement = aBook].! !

!Cart methodsFor: 'information' stamp: 'js 10/29/2019 20:36:31'!
contains: anISBN

	^ books includes: anISBN. ! !

!Cart methodsFor: 'information' stamp: 'js 10/29/2019 20:40:48'!
isEmpty

	^ books isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'A.B. 10/31/2019 09:29:03'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'js 10/29/2019 20:50:32'!
errorMessageAmountNegative

	^ 'Cannot add a negative amount of books to cart.'! !

!Cart class methodsFor: 'error messages' stamp: 'js 10/29/2019 20:48:01'!
errorMessageAmountZero

	^ 'Cannot add zero books to cart.'! !
