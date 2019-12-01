!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	self
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/30/2019 23:54:29'!
test07CartShouldBeEmptyAfterCheckout

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.
	
	cashier checkOut.
	
	self assert: cart isEmpty.! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemFacadeTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 6/19/2018 11:41:46'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) occurrencesOf: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:02'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:17'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:58'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'js 11/30/2019 18:15:26'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases lastPurchase |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	lastPurchase := purchases last.

	self assert: (lastPurchase amountOf: self validBook) equals: 2.
	self assert: (lastPurchase amountOf: self anotherValidBook) equals: 1.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:29'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:45'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 6/19/2018 11:40:51'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:23'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:33'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword

	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser

	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword

	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'js 11/30/2019 18:13:07'!
test10CanCheckoutACart

	| cartId purchases lastPurchase |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword).
	lastPurchase := purchases last.	

	self assert: (lastPurchase amountOf: self validBook) equals: 1.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:05:20'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: self invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'js 11/30/2019 17:35:02'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'js 11/30/2019 17:35:05'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'js 11/30/2019 17:35:27'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:15'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:32'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent occurrencesOf: self validBook) equals: 1.
	self assert: (cartContent occurrencesOf: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:42'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - catalog' stamp: 'js 11/30/2019 11:41:47'!
test20BooksInCatalogHaveCorrectNamePriceAndAuthor

	| catalog facadeCatalog tusLibrosFacade |
	
	catalog := Catalog new.
	catalog addBookIsbn: '0123456789' name: 'Libro Fantasma' price: 10 author: 'Nick'.
	
	tusLibrosFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: catalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock.
		
	facadeCatalog := tusLibrosFacade catalog.
	
	self assert: (facadeCatalog containsIsbn: '0123456789').
	self assert: 'Libro Fantasma' equals: (facadeCatalog nameOf: '0123456789').
	self assert: 10 equals: (facadeCatalog priceOf: '0123456789').
	self assert: 'Nick' equals: (facadeCatalog authorOf: '0123456789').


	


	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - catalog' stamp: 'js 12/1/2019 11:15:19'!
test21InvalidIsbnInCatalogRaisesError

	| catalog facadeCatalog tusLibrosFacade |
	
	catalog := Catalog new.
	catalog addBookIsbn: '0123456789' name: 'Libro Fantasma' price: 10 author: 'nn'.
	
	tusLibrosFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: catalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock.
		
	facadeCatalog := tusLibrosFacade catalog.
	
	self should: [ facadeCatalog nameOf: 'invalid isbn' ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: Catalog errorMsgInvalidIsbn equals: anError messageText. ].
	
	self should: [ facadeCatalog priceOf: 'another invalid isbn' ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |  self assert: Catalog errorMsgInvalidIsbn equals: anError messageText. ].
			
	self should: [ facadeCatalog authorOf: 'anotheranother invalid isbn' ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |  self assert: Catalog errorMsgInvalidIsbn equals: anError messageText. ].
	


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'js 11/27/2019 12:55:00'!
test22CannotRemoveItemsFromInvalidCart

	self
		should: [systemFacade remove: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'js 11/27/2019 13:58:52'!
test23CannotRemoveItemsFromEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	self
		should: [systemFacade remove: 1 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidRemovalErrorDescription ]

	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'js 11/27/2019 14:01:24'!
test24CannotRemoveMoreItemsItemsThanTotal

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.

	self
		should: [systemFacade remove: 3 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidRemovalErrorDescription.
			self assert: 2 equals: (systemFacade listCartIdentifiedAs: cartId) size. "No quite ninguno"
		].

	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'js 11/27/2019 14:04:55'!
test25RemovingItemsFromCartWorksCorrectly

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade remove: 2 of: self validBook toCartIdentifiedAs: cartId.
	
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty.
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'js 11/27/2019 14:03:48'!
assertEnoughCount: aQuantity of: anItem

	((items count: [ :containedItem | containedItem = anItem ]) < aQuantity) ifTrue: [ self error: self class invalidRemovalErrorDescription ].	
! !

!Cart methodsFor: 'assertions' stamp: 'js 11/27/2019 12:13:01'!
assertIsValidItem: anItem

	(catalog containsIsbn: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'js 11/30/2019 23:53:37'!
isEmpty

	^ items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'js 11/30/2019 23:48:36'!
clear

	items := Bag new.! !

!Cart methodsFor: 'removing' stamp: 'js 11/27/2019 13:58:43'!
remove: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	self assertEnoughCount: aQuantity of: anItem.
	
	aQuantity timesRepeat: [ items remove: anItem ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'js 11/27/2019 13:57:24'!
invalidRemovalErrorDescription

	^'No enough items to remove'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'js 11/27/2019 12:59:17'!
removeFromCart: anAmount of: aBook 

	^cart remove: anAmount of: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'js 11/30/2019 23:55:13'!
cleanCart

	^ cart clear! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'js 11/27/2019 12:14:33'!
totalOf: anItem quantity: aQuantity

	^(cart catalog priceOf: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'js 11/30/2019 23:55:37'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.
	self cleanCart.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Catalog category: #TusLibros!
Object subclass: #Catalog
	instanceVariableNames: 'names prices authors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/30/2019 11:42:25'!
addBookIsbn: isbn name: aName price: aPrice author: anAuthor

	names at: isbn put: aName.
	prices at: isbn put: aPrice.
	authors at: isbn put: anAuthor.! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/30/2019 11:42:25'!
authorOf: isbn

	^ authors at: isbn ifAbsent: [ self error: self class errorMsgInvalidIsbn ].! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/27/2019 12:09:07'!
containsIsbn: anItem

	^ names includesKey: anItem.

	! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/30/2019 11:42:25'!
initialize

	names := Dictionary new.
	prices := Dictionary new.
	authors := Dictionary new.! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/27/2019 12:43:53'!
itemsDo: aBlock

	^ names keysDo: aBlock.
! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/27/2019 12:35:45'!
nameOf: isbn

	^ names at: isbn ifAbsent: [ self error: self class errorMsgInvalidIsbn ].! !

!Catalog methodsFor: 'as yet unclassified' stamp: 'js 11/27/2019 12:35:50'!
priceOf: isbn

	^ prices at: isbn ifAbsent: [ self error: self class errorMsgInvalidIsbn ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalog class' category: #TusLibros!
Catalog class
	instanceVariableNames: ''!

!Catalog class methodsFor: 'as yet unclassified' stamp: 'js 11/27/2019 12:35:29'!
errorMsgInvalidIsbn

	^ 'ISBN not regirtered in catalog'.! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #ManualClock category: #TusLibros!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #TusLibros!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #TusLibros!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'js 11/24/2019 14:10:39'!
quantity

	^ quantity! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #TusLibros!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'testing' stamp: 'js 11/30/2019 18:14:46'!
amountOf: anItem

	^ ticket amountOf: anItem.! !

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !


!Sale methodsFor: 'private' stamp: 'js 11/30/2019 18:22:50'!
ticket

	^ ticket.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore

	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore

	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice

	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart

	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'js 11/30/2019 11:39:46'!
defaultCatalog

	| catalog |
	
	catalog := Catalog new.
	catalog addBookIsbn: self itemSellByTheStore name: 'Libro Fantasma' price: self itemSellByTheStorePrice author: 'Gasper'.
	catalog addBookIsbn: self anotherItemSellByTheStore name: 'Libro Zombie' price: self anotherItemSellByTheStorePrice author: 'Zasper'.

	^ catalog.
! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today

	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'total' stamp: 'js 11/30/2019 18:19:04'!
amountOf: aBook
	
	| amount |
	
	amount := 0.
	self lineItemsDo: [ :aLineItem | (aLineItem item = aBook) 
		ifTrue: [ amount := amount + aLineItem quantity ] ].
	
	^ amount.! !

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'js 11/30/2019 18:00:32'!
initialize

	lineItems := OrderedCollection new.! !

!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !

!Ticket methodsFor: 'initialization' stamp: 'js 11/30/2019 18:01:03'!
isEmpty

	^ lineItems isEmpty.! !


!Ticket methodsFor: 'line items' stamp: 'js 11/30/2019 17:55:30'!
add: aLineItems

	lineItems add: aLineItems copy.! !

!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosSystemExternAPI category: #TusLibros!
Object subclass: #TusLibrosSystemExternAPI
	instanceVariableNames: 'webServer tusLibros portNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemExternAPI methodsFor: 'web responses' stamp: 'js 11/27/2019 11:04:48'!
send200Response: aRequest withKey: aKey withValue: aValue

	| response |
	
	response := Dictionary new.
	response at: aKey put: aValue.
			
	aRequest send200Response: ((WebUtils jsonEncode: response)) asUtf8
		contentType: 'application/json; charset=utf-8' do: [:resp |
			resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]  
	

	! !

!TusLibrosSystemExternAPI methodsFor: 'web responses' stamp: 'js 11/27/2019 11:06:46'!
send200SuccesIn: aRequest withValue: aValue

	self send200Response: aRequest withKey: 'result' withValue: aValue.! !

!TusLibrosSystemExternAPI methodsFor: 'web responses' stamp: 'js 11/27/2019 11:06:23'!
send200ifErrorIn: aRequest running: aBlock

	aBlock on: Error do: [ :anError | 
		self send200Response: aRequest withKey: 'error' withValue: anError messageText. ].

	! !

!TusLibrosSystemExternAPI methodsFor: 'web responses' stamp: 'js 11/22/2019 20:09:39'!
send400ifErrorIn: aRequest running: aBlock

	aBlock on: Error do: [ :anError | aRequest send400Response ] .


	! !


!TusLibrosSystemExternAPI methodsFor: 'clock' stamp: 'A.B 11/21/2019 20:15:29'!
clock

	^ self! !

!TusLibrosSystemExternAPI methodsFor: 'clock' stamp: 'A.B 11/21/2019 20:15:40'!
now

	^ DateAndTime now.! !

!TusLibrosSystemExternAPI methodsFor: 'clock' stamp: 'A.B 11/21/2019 20:15:46'!
today

	^ DateAndTime today.! !


!TusLibrosSystemExternAPI methodsFor: 'merchant processor' stamp: 'a.b. 12/1/2019 15:08:51'!
debit: anAmount from: aCreditCard
! !

!TusLibrosSystemExternAPI methodsFor: 'merchant processor' stamp: 'A.B 11/21/2019 20:16:02'!
merchantProcessor

	^ self! !


!TusLibrosSystemExternAPI methodsFor: 'initialization' stamp: 'js 12/1/2019 10:18:42'!
initializeWebServices

	webServer addService: '/createCart' action: [ :request | self serviceCreateCart: request ].
	webServer addService: '/addToCart' action: [ :request | self serviceAddToCart: request ].
	webServer addService: '/removeFromCart' action: [ :request | self serviceRemoveFromCart: request ].
	webServer addService: '/listCart' action: [ :request | self serviceListCart: request ].
	webServer addService: '/checkOutCart' action: [ :request | self serviceCheckoutCart: request ].
	webServer addService: '/listPurchases' action: [ :request | self serviceListPurchases: request ].
	webServer addService: '/catalog' action: [ :request | self serviceCatalog: request ]! !

!TusLibrosSystemExternAPI methodsFor: 'initialization' stamp: 'js 12/1/2019 10:18:42'!
initializeWith: aPortNumber
	
	portNumber := aPortNumber.

	tusLibros := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: self tusLibrosCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: self clock.

	webServer := WebServer new listenOn: portNumber.

	self initializeWebServices.

! !

!TusLibrosSystemExternAPI methodsFor: 'initialization' stamp: 'js 12/1/2019 10:58:56'!
process: request obtainingFields: anObtainingBlock doing: aMainBlock replying: aReplyBlock

	self send400ifErrorIn: request running: anObtainingBlock.

	self send200ifErrorIn: request running: aMainBlock.

	self send200SuccesIn: request withValue: (aReplyBlock value).


! !


!TusLibrosSystemExternAPI methodsFor: 'formatting' stamp: 'js 12/1/2019 10:36:00'!
formattingCart: cartItems

	| cartItemsMap |
	
	cartItemsMap := Dictionary new.
	cartItems sortedElements do: [ :aPair |
		cartItemsMap at: aPair key put: aPair value.
	].
	^ cartItemsMap
! !

!TusLibrosSystemExternAPI methodsFor: 'formatting' stamp: 'js 12/1/2019 10:36:11'!
formattingCatalog: catalog

	| formattedCatalog bookMap |
	
	formattedCatalog := OrderedCollection new.
	
	catalog itemsDo: [ :anItem |
		bookMap := Dictionary new.
		bookMap at: 'price' put: (catalog priceOf: anItem).
		bookMap at: 'name' put: (catalog nameOf: anItem).
		bookMap at: 'isbn' put: (anItem asString).
		bookMap at: 'author' put: (catalog authorOf: anItem).
		formattedCatalog add: bookMap.
	].

	^ formattedCatalog asArray.
! !

!TusLibrosSystemExternAPI methodsFor: 'formatting' stamp: 'js 12/1/2019 10:38:25'!
formattingPurchasesInfo: purchasesInfo

	| formatedPurchases |
	
	formatedPurchases := OrderedCollection new.
	purchasesInfo do: [ :aSale | 
		formatedPurchases add: (self formattingTicket: aSale ticket).
	].
	^ formatedPurchases asArray.
! !

!TusLibrosSystemExternAPI methodsFor: 'formatting' stamp: 'js 12/1/2019 10:38:37'!
formattingTicket: ticket

	| itemMap ticketItems |
	
	ticketItems := OrderedCollection new.
	
	ticket lineItemsDo: [ :anItem |
		itemMap := Dictionary new.
		itemMap at: 'item' put: anItem item.
		itemMap at: 'quantity' put: anItem quantity.
		itemMap at: 'total' put: anItem total.
		ticketItems add: itemMap.
	].
	^ ticketItems asArray
! !


!TusLibrosSystemExternAPI methodsFor: 'web server listener' stamp: 'A.B 11/21/2019 20:12:49'!
destroy

	webServer ifNotNil:[webServer destroy].! !

!TusLibrosSystemExternAPI methodsFor: 'web server listener' stamp: 'js 11/27/2019 10:14:50'!
startListening

	webServer startListener.

	^ 'Listening on port: ', portNumber asString.
	! !

!TusLibrosSystemExternAPI methodsFor: 'web server listener' stamp: 'js 11/27/2019 10:14:53'!
stopListening

	webServer stopListener.

	^'Stopped listening from port: ', portNumber asString! !


!TusLibrosSystemExternAPI methodsFor: 'string parsing' stamp: 'js 12/1/2019 10:14:51'!
buildMonthOfYearFromString: mmyyyy
	
	^ Month month: (mmyyyy copyFrom: 1 to: 2) asInteger 
			    year: (mmyyyy copyFrom: 3 to: 6) asInteger
! !


!TusLibrosSystemExternAPI methodsFor: 'business info' stamp: 'A.B 11/21/2019 20:18:16'!
createSalesBook

	^ OrderedCollection new.
	! !

!TusLibrosSystemExternAPI methodsFor: 'business info' stamp: 'js 12/1/2019 11:24:28'!
tusLibrosCatalog

	^ Catalog new
	   addBookIsbn: '9780756407919' name: 'The Wise Man s Fear' price: 500 author: 'Patrick Rothfuss';
        addBookIsbn: '9788432311451' name: 'Las venas abiertas de América Latina' price: 540 author: 'Eduardo Galeano';
        addBookIsbn: '9788420650852' name: 'La tregua' price: 858 author: 'Mario Benedetti';
        addBookIsbn: '9788426400260' name: '1984' price: 999 author: 'George Orwell';
        addBookIsbn: '9871138148000' name: 'Cien años de soledad' price: 750 author: 'Gabriel García Marquez';
        addBookIsbn: '9780262033848' name: 'Introduction to Algorithms, 3rd Edition' price: 5369 author: 'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein';
        addBookIsbn: '9780201633610' name: 'Design Patterns: Elements of Reusable Object-Oriented Software' price: 954 author: 'Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides';
        addBookIsbn: '4815162342000' name: 'Turns out it was not Penny s boat' price: 815 author: 'Charlie Pace';
        addBookIsbn: '9780553293357' name: 'Foundation' price: 754 author: 'Isaac Asimov';
        addBookIsbn: '2311196320190' name: 'The wibbly wobbly timey wimey beggining of Time' price: 2 author: 'The Doctor'.! !

!TusLibrosSystemExternAPI methodsFor: 'business info' stamp: 'a.b. 12/1/2019 15:19:01'!
validUsersAndPasswords

	
	^ Dictionary new at: 'pepe' put: 'pass';
						   at: 'juana' put: 'qwerty';
						   at: 'abrete' put: 'sesamo';
					yourself.
	! !


!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:01:20'!
serviceAddToCart: request

	| bookIsbn bookQuantity cartId |

	self 
		process: request 
		obtainingFields:  
			[ cartId := (request fields at: 'cartId') asInteger.
		 	bookIsbn := (request fields at: 'bookIsbn').
			bookQuantity := (request fields at: 'bookQuantity') asInteger. ]
		doing:  
			[ tusLibros add: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId ]
		replying: 
			[ 'OK' ].
! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:28:05'!
serviceCatalog: request 

	| catalog |
	
	self 
		process: request
		obtainingFields: []
		doing: [ catalog := tusLibros catalog ]
		replying: [ self formattingCatalog: catalog ].
! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:04:12'!
serviceCheckoutCart: request 

	| cartId ccn cced cco monthOfYearExpiration ticket |
	
	self 
		process: request 
		obtainingFields:  
			[ cartId := (request fields at: 'cartId') asInteger.
			  ccn := (request fields at: 'ccn').
			  cced := (request fields at: 'cced').
			  cco := (request fields at: 'cco'). 
			
			  (ccn size = 16) ifFalse: [ self error: 'Invalid credit card number' ].
			  (cced size = 6) ifFalse: [ self error: 'Invalid credit card expiration date' ].
	   	  (cco size = 0) ifTrue: [ self error: 'Invalid credit card owner' ]]
		doing:
			[  monthOfYearExpiration := self buildMonthOfYearFromString: cced. 
				ticket := tusLibros checkOutCartIdentifiedAs: cartId 
				withCreditCardNumbered: ccn 
				ownedBy: cco 
				expiringOn: monthOfYearExpiration ]
		replying: 
			[ self formattingTicket: ticket ].
	
! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:05:11'!
serviceCreateCart: request 

	| clientId password cartId |
	
	self
		process: request
		obtainingFields:  
			[ clientId := (request fields at: 'clientId').
		 	password := (request fields at: 'password') ]
		doing: 
			[ cartId := tusLibros createCartFor: clientId authenticatedWith: password.]
		replying: 
			[ cartId ].
! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:06:33'!
serviceListCart: request 

	| cartId cartList |
	
	self 
		process: request 
		obtainingFields:  [ cartId := (request fields at: 'cartId') asInteger. ]
		doing:  [ cartList := tusLibros listCartIdentifiedAs: cartId ]
		replying:  [ self formattingCart: cartList ].

! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:07:28'!
serviceListPurchases: request 

	| clientId password purchasesInfo |

	self 
		process: request
		obtainingFields:  
			[ clientId := (request fields at: 'clientId').
			 password := (request fields at: 'password'). ]
		doing: 
			[ purchasesInfo := tusLibros listPurchasesOf: clientId authenticatingWith: password ] 
		replying: 
			[ self formattingPurchasesInfo: purchasesInfo ].
! !

!TusLibrosSystemExternAPI methodsFor: 'web services initialization' stamp: 'js 12/1/2019 11:08:34'!
serviceRemoveFromCart: request 

	| bookIsbn bookQuantity cartId |
	
	self 
		process: request
	  	obtainingFields:
			[ cartId := (request fields at: 'cartId') asInteger.
		 	bookIsbn := (request fields at: 'bookIsbn').
			bookQuantity := (request fields at: 'bookQuantity') asInteger. ]		  
		doing:  
			[ tusLibros remove: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId ]
		replying: 
			[ 'OK' ].

! !


!classDefinition: #TusLibrosSystemFacade category: #TusLibros!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'js 11/27/2019 12:09:35'!
catalog

	^ catalog.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'js 11/24/2019 12:01:41'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | 
			^ cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'js 11/30/2019 18:08:12'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [
		^ (self salesDoneBy: aUser).
	].

		! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'js 11/27/2019 12:56:18'!
remove: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'js 11/30/2019 18:06:35'!
ticketWithMergedSales: sales
	
	| finalTicket |
	finalTicket := Ticket new.
	
	sales do: [ :aTicket |
		aTicket lineItemsDo: [:lineItem | finalTicket add: lineItem]
	].

	^ finalTicket! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'js 11/24/2019 14:10:48'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldQuantity newQuantity |
		oldQuantity := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newQuantity := oldQuantity + aLineItem quantity.
		salesOrderedByBook at: aLineItem item put: newQuantity ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #TusLibros!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !
