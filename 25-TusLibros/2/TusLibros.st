!classDefinition: #CartTest category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'support' stamp: 'js 11/5/2019 22:43:32'!
createCart
	
	^ Cart acceptingItemsOf: self defaultPriceList.! !

!CartTest methodsFor: 'support' stamp: 'js 11/5/2019 22:43:13'!
defaultPriceList
	
	| priceList |
	
	priceList := Dictionary new.
	priceList at: self itemSellByTheStore put: 50.

	^ priceList .
	! !

!CartTest methodsFor: 'support' stamp: 'js 11/5/2019 22:43:25'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'A.B. 11/3/2019 11:30:49'!
test09CartDoesNotAddNonIntegerQuantity

	| cart |
	
	cart := self createCart.
	
	self should: [cart add: 2.5 of: self itemSellByTheStore.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | 
							self assert: cart invalidQuantityErrorMessage equals: anError messageText.
							self assert: (cart occurrencesOf: self itemSellByTheStore) = 0 ].
	! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'merchantProcessorAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 22:37:59'!
cartWithElements
	
	| aCart |
	
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore.
	
	^ aCart! !

!CashierTest methodsFor: 'support' stamp: 'js 11/4/2019 18:50:39'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList ! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 22:52:59'!
debit: anAmount from: aCreditCard

	^ merchantProcessorAction value.! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 20:37:37'!
defaultCreditCard

	| cardDate cardId cardName creditCard |
	
	cardId := '0123456789012345'.
	cardName := 'Ada'.
	cardDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 1.
	creditCard := CreditCard withId: cardId withName: cardName withExpirationDate: cardDate.
	
	^ creditCard.

! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 20:38:57'!
defaultDateToTest

	^ (FixedGregorianDate yearNumber: 2019 monthNumber: 1 dayNumber: 1).
! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 22:56:27'!
defaultMerchantProcessor

	merchantProcessorAction := [].
	^ self.
! !

!CashierTest methodsFor: 'support' stamp: 'A.B. 11/3/2019 12:18:29'!
defaultPriceList
	
	|priceList|
	priceList := Dictionary new.
	priceList at: self itemSellByTheStore put: 50.

	^ priceList .
	! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 22:20:52'!
defaultSalesBook

	^ OrderedCollection new.

! !

!CashierTest methodsFor: 'support' stamp: 'A.B. 11/3/2019 11:51:12'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'support' stamp: 'js 11/5/2019 22:57:39'!
merchantProcessorWithAction: anAction

	merchantProcessorAction := anAction.
	^ self.
! !


!CashierTest methodsFor: 'setup' stamp: 'js 11/5/2019 22:53:26'!
setup

	merchantProcessorAction := []

! !


!CashierTest methodsFor: 'test' stamp: 'js 11/5/2019 22:56:03'!
test01EmptyCarShouldtRaiseErrorOnCheckout

	| anEmptyCart aSalesBook |
	
	anEmptyCart := self createCart.
	aSalesBook := OrderedCollection new.

	self should: [ Cashier onDate: self defaultDateToTest 
					withPriceList: self defaultPriceList 
					withSalesBook: aSalesBook 
					withMP: self defaultMerchantProcessor
					withCart: anEmptyCart 
					withCreditCard: self defaultCreditCard . ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | 
				self assert: Cashier errorMessageEmptyCartCheckout equals: anError messageText . 
				self assert: aSalesBook isEmpty.
			].
	
	! !

!CashierTest methodsFor: 'test' stamp: 'js 11/5/2019 22:56:03'!
test02CartWithOneItemSumsCorrectly

	|cashier aCart total|
	
	aCart := self createCart.
	aCart add: 1 of: self itemSellByTheStore .
	
	cashier := Cashier onDate: self defaultDateToTest 
						withPriceList: self defaultPriceList 
						withSalesBook: self defaultSalesBook 
						withMP: self defaultMerchantProcessor
						withCart: aCart 
						withCreditCard: self defaultCreditCard .

	total := cashier checkOut.
	
	self assert: 50 equals: total. ! !

!CashierTest methodsFor: 'test' stamp: 'js 11/5/2019 22:56:03'!
test03CartWithMoreThanOneItemSumsCorrectly

	|cashier aCart total|
	
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore.
	
	cashier := Cashier onDate: self defaultDateToTest 
						withPriceList: self defaultPriceList 
						withSalesBook: self defaultSalesBook
						withMP: self defaultMerchantProcessor 
						withCart: aCart 
						withCreditCard: self defaultCreditCard.
						
	total := cashier checkOut.
	
	self assert: 100 equals: total. ! !

!CashierTest methodsFor: 'test' stamp: 'js 11/6/2019 20:30:00'!
test04CheckOutWithLongCardNameRaisesErrorCreatingCashier

	"Consideramos que no tiene sentido enviarle al MerchantProcessor un nombre de mas de 30 caracteres cuando ya sabemos que es invalido"

	| expirationDate creditCard dateToTest salesBook |
	
	expirationDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 1.
	creditCard := CreditCard withId: '0123456789012345' 
								withName: 'aNameLongerThanThirtyCharacters' 
								withExpirationDate: expirationDate.
	
	dateToTest := (FixedGregorianDate yearNumber: 2019 monthNumber: 1 dayNumber: 1).
	
	salesBook := OrderedCollection new.
	
	self should: [ Cashier onDate: dateToTest 
					withPriceList: self defaultPriceList 
					withSalesBook: salesBook 
					withMP: self defaultMerchantProcessor 
					withCart: self cartWithElements 
					withCreditCard: creditCard. ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | 
				self assert: Cashier errorMessageCardNameTooLong equals: anError messageText . 
				self assert: salesBook isEmpty.		
		].
	! !

!CashierTest methodsFor: 'test' stamp: 'js 11/6/2019 20:29:17'!
test05ExpiredCardShouldRaiseErrorCreatingCashier

	| expirationDate creditCard dateToTest salesBook |
	
	expirationDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 1.
	creditCard := CreditCard withId: '0123456789012345'
								withName: 'Ada' 
								withExpirationDate: expirationDate.
	
	dateToTest := (FixedGregorianDate yearNumber: 2022 monthNumber: 1 dayNumber: 1).
	
	salesBook := OrderedCollection new.
	
	self should: [ Cashier onDate: dateToTest 
					withPriceList: self defaultPriceList 
					withSalesBook: salesBook
					withMP: self defaultMerchantProcessor 
					withCart: self cartWithElements 
					withCreditCard: creditCard. ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | 
				self assert: Cashier errorMessageExpiredCreditCard equals: anError messageText.
				self assert: salesBook isEmpty.
			 ].
	! !

!CashierTest methodsFor: 'test' stamp: 'js 11/5/2019 22:59:19'!
test06CheckoutWithMPErrorCanBeHandledCorrectly

	| cashier aMerchantProcessor salesBook |

	
	aMerchantProcessor := self merchantProcessorWithAction: [ self error: self class errorMessageMerchantProcessorError ].
	
	salesBook := OrderedCollection new.
	
	cashier := Cashier onDate: self defaultDateToTest 
					withPriceList: self defaultPriceList 
					withSalesBook: salesBook
					withMP: aMerchantProcessor 
					withCart: self cartWithElements 
					withCreditCard: self defaultCreditCard .

	self should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: self class errorMessageMerchantProcessorError.
			self assert: salesBook isEmpty.
		 ]! !

!CashierTest methodsFor: 'test' stamp: 'js 11/5/2019 22:56:03'!
test07SalesBookIsFilledCorrectlyWhenCheckingOut

	|cashier aCart salesBook |
	
	aCart := self cartWithElements.
	
	salesBook := OrderedCollection new.
	
	cashier := Cashier onDate: self defaultDateToTest 
					withPriceList: self defaultPriceList 
					withSalesBook: salesBook
					withMP: self defaultMerchantProcessor
					withCart: aCart 
					withCreditCard: self defaultCreditCard .

	cashier checkOut.

	self assert: 1 equals: salesBook size.
	self assert: (salesBook includes: aCart).
		 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierTest class' category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
CashierTest class
	instanceVariableNames: ''!

!CashierTest class methodsFor: 'error - messages' stamp: 'js 11/5/2019 22:58:46'!
errorMessageMerchantProcessorError

	^ 'Merchant processor error. FInantial error.'! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'js 11/4/2019 19:12:14'!
test01InvalidAmountOfDigitsRaisesError

	| cardDate cardIdInvalid cardName |
	
	cardIdInvalid := '012345678901234'.  "15 digits should fail"
	cardName := 'Ada'.
	cardDate := GregorianMonthOfYear year: 2020 monthNumber: 1.
	
	self should: [ 	 	
		CreditCard withId: cardIdInvalid withName: cardName withExpirationDate: cardDate.
	]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard errorMsgInvalidNumber.
		]
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'js 11/4/2019 19:12:35'!
test02CanCreateValidCardAndRemebersInformation
	
	| cardId creditCard cardDate cardName |
	
	cardId := '0123456789012345'.
	cardName := 'Ada'.
	cardDate := GregorianMonthOfYear year: 2020 monthNumber: 1.
	
	creditCard := CreditCard withId: cardId withName: cardName withExpirationDate: cardDate.
	
	self assert: creditCard id equals: cardId.
	self assert: creditCard name equals: cardName.
	self assert: creditCard expirationDate equals: cardDate.! !

!CreditCardTest methodsFor: 'tests' stamp: 'js 11/4/2019 19:37:44'!
test03ExpiredCardIsExpired
	
	| cardId creditCard cardDate cardName dateToTest |
	
	cardId := '0123456789012345'.
	cardName := 'Ada'.
	cardDate := GregorianMonthOfYear yearNumber: 2020 monthNumber: 1.
		
	creditCard := CreditCard withId: cardId withName: cardName withExpirationDate: cardDate.
	
	dateToTest := (FixedGregorianDate yearNumber: 2021 monthNumber: 1 dayNumber: 1).
	self assert: (creditCard isExpiredOn: dateToTest).! !

!CreditCardTest methodsFor: 'tests' stamp: 'js 11/4/2019 19:37:54'!
test04NonExpiredCardIsNotExpired
	
	| cardId creditCard cardDate cardName dateToTest |
	
	cardId := '0123456789012345'.
	cardName := 'Ada'.
	cardDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 1.
	
	creditCard := CreditCard withId: cardId withName: cardName withExpirationDate: cardDate.
	
	dateToTest := (FixedGregorianDate yearNumber: 2019 monthNumber: 1 dayNumber: 1).
	self deny: (creditCard isExpiredOn: dateToTest).! !

!CreditCardTest methodsFor: 'tests' stamp: 'js 11/4/2019 20:15:51'!
test05CardWithEmptyNameIsNotValid
	
	| cardId cardDate cardName |
	
	cardId := '0123456789012345'.
	cardName := ''.
	cardDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 1.
	self should: [ CreditCard withId: cardId withName: cardName withExpirationDate: cardDate. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard errorMsgInvalidName.
		]
! !


!classDefinition: #Cart category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'js 11/4/2019 18:47:43'!
assertIsValidItem: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'A.B. 11/3/2019 11:32:18'!
assertIsValidQuantity: aQuantity

	(aQuantity strictlyPositive and: [aQuantity isInteger]) ifFalse: [ self error: self invalidQuantityErrorMessage ].! !


!Cart methodsFor: 'initialization' stamp: 'js 11/4/2019 18:47:43'!
initializeAcceptingItemsOf: aCatalog

	priceList := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'cost' stamp: 'js 11/4/2019 18:51:28'!
totalCost

	^ items sum: [ :aBook | priceList at: aBook ] ifEmpty: [ 0 ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
Object subclass: #Cashier
	instanceVariableNames: 'currentDate priceList merchantProcessor cart creditCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'js 11/5/2019 22:35:56'!
assertExpirationOf: aCreditCard on: aCheckoutDate

	(aCreditCard isExpiredOn: aCheckoutDate) ifTrue: [ self error: self class errorMessageExpiredCreditCard ].! !

!Cashier methodsFor: 'assertions' stamp: 'js 11/5/2019 22:36:23'!
assertValidCardName: aCreditCard

	(aCreditCard nameLength > 30) ifTrue: [self error: self class errorMessageCardNameTooLong ].
! !

!Cashier methodsFor: 'assertions' stamp: 'js 11/5/2019 21:24:56'!
assertValidCart: aCart.

	aCart isEmpty ifTrue: [self error: self class errorMessageEmptyCartCheckout ]! !


!Cashier methodsFor: 'checkout' stamp: 'js 11/5/2019 22:31:59'!
checkOut

	| subtotal |

	subtotal := cart totalCost .
	merchantProcessor debit: subtotal from: creditCard.
	
	salesBook add: cart.

	^ subtotal .! !


!Cashier methodsFor: 'initialization' stamp: 'js 11/5/2019 22:23:44'!
initializeOnDate: aDate withPriceList: aPriceList withSalesBook: aSalesBook withMP: MP withCart: aCart withCreditCard: aCreditCard

	self assertValidCart: aCart.
	self assertValidCardName: aCreditCard.
	self assertExpirationOf: aCreditCard on: aDate.

	salesBook := aSalesBook.
	currentDate := aDate.
	priceList := aPriceList.
	merchantProcessor := MP.
	cart := aCart.
	creditCard := aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'js 11/5/2019 22:23:19'!
onDate: aDate withPriceList: aPriceList withSalesBook: aSalesBook withMP: MP withCart: aCart withCreditCard: aCreditCard
	
	^ self new initializeOnDate: aDate withPriceList: aPriceList withSalesBook: aSalesBook withMP: MP withCart: aCart withCreditCard: aCreditCard! !


!Cashier class methodsFor: 'error messages' stamp: 'js 11/5/2019 22:35:21'!
errorMessageCardNameTooLong
	
	^ 'Card name too long'.! !

!Cashier class methodsFor: 'error messages' stamp: 'js 11/5/2019 21:22:56'!
errorMessageEmptyCartCheckout
	
	^ 'Cannot checkout an empty cart'.! !

!Cashier class methodsFor: 'error messages' stamp: 'js 11/5/2019 22:35:56'!
errorMessageExpiredCreditCard
	
	^ 'Expired credit card.'.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
Object subclass: #CreditCard
	instanceVariableNames: 'idNumber name expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'js 11/4/2019 20:16:46'!
withId: cardId withName: cardName withExpirationDate: cardDate

	(cardName isEmpty) ifTrue: [ self error: self class errorMsgInvalidName ].
	(cardId size = 16) ifFalse: [self error: self class errorMsgInvalidNumber ].
	
	idNumber := cardId.
	name := cardName.
	expirationDate := cardDate.
! !


!CreditCard methodsFor: 'expiration' stamp: 'js 11/4/2019 19:10:36'!
expirationDate

	^ expirationDate.
! !

!CreditCard methodsFor: 'expiration' stamp: 'js 11/4/2019 19:34:06'!
isExpiredOn: aDate

	^ expirationDate < aDate monthOfYear ! !


!CreditCard methodsFor: 'name' stamp: 'js 11/4/2019 19:10:26'!
name

	^ name
! !

!CreditCard methodsFor: 'name' stamp: 'js 11/5/2019 20:13:58'!
nameLength

	^ name size.
! !


!CreditCard methodsFor: 'id' stamp: 'js 11/4/2019 19:03:52'!
id

	^ idNumber
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'js 11/6/2019 20:30:27'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error message' stamp: 'js 11/4/2019 20:16:06'!
errorMsgInvalidName

	^ 'Invalid card name'.! !

!CreditCard class methodsFor: 'error message' stamp: 'js 11/4/2019 19:01:00'!
errorMsgInvalidNumber

	^ 'Invalid id number'.! !


!CreditCard class methodsFor: 'instance creation' stamp: 'js 11/4/2019 19:09:36'!
withId: cardId withName: cardName withExpirationDate: cardDate

	^ self new withId: cardId withName: cardName withExpirationDate: cardDate.! !
