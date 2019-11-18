!classDefinition: #CartTest category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'js 11/13/2019 14:10:09'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := SalesBook new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/13/2019 14:10:20'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: SalesBook new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/13/2019 14:10:25'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := SalesBook new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/14/2019 13:34:03'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := SalesBook new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/13/2019 14:10:31'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := SalesBook new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'js 11/13/2019 14:10:34'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := SalesBook new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
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


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #MarketInterfaceTest category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
TestCase subclass: #MarketInterfaceTest
	instanceVariableNames: 'itemFactory mpAction anotherList dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketInterfaceTest methodsFor: 'default items' stamp: 'A.B. 11/15/2019 23:02:15'!
createCartForDefaultUserIn: aMarket
	
	^ aMarket createCartForUser: self defaultUsername 
				password: self defaultUsernamePassword .
	! !

!MarketInterfaceTest methodsFor: 'default items' stamp: 'A.B. 11/16/2019 15:10:31'!
defaultMarket

	^ MarketInterface withUserPasswords: self defaultUserPasswords 
							withPriceList: itemFactory defaultCatalog 
							withMP: self 
							withTimeGuru: self.
	! !

!MarketInterfaceTest methodsFor: 'default items' stamp: 'A.B. 11/16/2019 12:33:49'!
defaultUserPasswords

	| aDict |
	
	aDict := Dictionary new.
	aDict at: self defaultUsername put: self defaultUsernamePassword .
	aDict at: 'anotherDefaultUser' put: 'passwordsupersegura2'.

	
	^ aDict.! !

!MarketInterfaceTest methodsFor: 'default items' stamp: 'A.B. 11/15/2019 23:00:54'!
defaultUsername

	^ 'defaultUser'.! !

!MarketInterfaceTest methodsFor: 'default items' stamp: 'A.B. 11/15/2019 23:01:16'!
defaultUsernamePassword

	^ 'passwordsupersegura'.! !


!MarketInterfaceTest methodsFor: 'setUp' stamp: 'A.B. 11/16/2019 14:03:38'!
setUp

	mpAction := [ :anAmount :aCreditCard | ].
	itemFactory := StoreTestObjectsFactory new.
	dateAndTime := DateAndTime year: 2019 month: 11 day: 20 hour: 15 minute: 30. ! !


!MarketInterfaceTest methodsFor: 'timeGuru' stamp: 'A.B. 11/16/2019 14:03:38'!
dateAndTime

	^ dateAndTime.! !

!MarketInterfaceTest methodsFor: 'timeGuru' stamp: 'A.B. 11/16/2019 14:03:38'!
fastForwardMinutes: anAmountOfMinutes

	dateAndTime := dateAndTime + (Duration minutes: anAmountOfMinutes).! !


!MarketInterfaceTest methodsFor: 'merchantProcessor' stamp: 'A.B 11/11/2019 19:39:29'!
debit: anAmount from: aCreditCard 

	^ mpAction value: anAmount value: aCreditCard 
	! !


!MarketInterfaceTest methodsFor: 'tests - createCart' stamp: 'A.B. 11/15/2019 22:53:30'!
test01NewlyCreatedCartIsEmpty

	| cartID market |

	market := self defaultMarket.
		
	cartID := self createCartForDefaultUserIn: market.
	
	self assert: ((market listCart: cartID) isEmpty). ! !

!MarketInterfaceTest methodsFor: 'tests - createCart' stamp: 'A.B. 11/15/2019 22:54:43'!
test02CreatingCartsReturnDifferentIDs

	| cartID market anotherCartID |

	market := self defaultMarket.		
		
	cartID := self createCartForDefaultUserIn: market .
	
	anotherCartID := market createCartForUser: 'anotherDefaultUser' password:'passwordsupersegura2'.
	
	self deny: (cartID = anotherCartID) . ! !

!MarketInterfaceTest methodsFor: 'tests - createCart' stamp: 'A.B. 11/15/2019 23:07:29'!
test08CreatingCartWithIncorrectPasswordRaisesError

	| market |
	
	market := self defaultMarket.		
		
	self should: [ market createCartForUser: self defaultUsername password: 'incorrect-password'. ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: MarketInterface errorInvalidPassword.
! !

!MarketInterfaceTest methodsFor: 'tests - createCart' stamp: 'A.B. 11/15/2019 21:59:37'!
test09CreatingCartWithInvalidUserRaisesError

	| market |

	market := self defaultMarket.		
		
	self should: [ market createCartForUser: 'inexistent-user' password: 'password'. ]  
	raise: Error - MessageNotUnderstood 
	withMessageText: MarketInterface errorInvalidUser.
! !


!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'A.B. 11/15/2019 22:55:26'!
test03OneBookAddedToCartIsListed

	| cartID market book |

	market := self defaultMarket.		
	
	cartID :=  self createCartForDefaultUserIn: market .
	
	book:= itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 1.
	
	self assert: (market listCart: cartID ) includes: book. 
	self assert: 1 equals: (market listCart: cartID ) size.! !

!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'A.B. 11/15/2019 22:55:38'!
test04MoreThanOneBookAddedAreListedCorrectly

	| cartID market book |
	
	market := self defaultMarket.		
	
	cartID := self createCartForDefaultUserIn: market .
	
	book:= itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 2.
	
	self assert: 2 equals: ((market listCart: cartID ) occurrencesOf: book). 
	self assert: 2 equals: (market listCart: cartID ) size.! !

!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'A.B. 11/15/2019 22:55:53'!
test05DifferentCartsCanBeListedCorrectly

	| cartID market book anotherCartID |

	market := self defaultMarket.		
	
	cartID := self createCartForDefaultUserIn: market.
	
	anotherCartID := market createCartForUser: 'anotherDefaultUser' password:'passwordsupersegura2'.
	
	book:= itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 2.
	market addToCart: anotherCartID book: book amount: 7.
	
	self assert: 2 equals: ((market listCart: cartID ) occurrencesOf: book). 
	self assert: 2 equals: (market listCart: cartID ) size.
	
	self assert: 7 equals: ((market listCart: anotherCartID ) occurrencesOf: book). 
	self assert: 7 equals: (market listCart: anotherCartID ) size.! !

!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'js 11/18/2019 11:22:02'!
test06ListingNonExistantCartIDRaisesError

	| market |

	market := self defaultMarket.		

	self should: [market listCart: -1] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: MarketInterface errorNonExistantCart.! !

!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'js 11/18/2019 11:22:07'!
test22ListingExpiredCartRaisesError

	| market cartID |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	self fastForwardMinutes: 30.
	
	self should: [market listCart: cartID .]  
		 raise: Error - MessageNotUnderstood  
		 withMessageText: market class errorExpiredCart.! !

!MarketInterfaceTest methodsFor: 'tests - listCart' stamp: 'js 11/18/2019 10:40:27'!
test24CartCanBeUsedForMoreThanThirtyMinutesAfterCreation

	"The 30min rule is from last usage, not from creation"

	| market cartID |

	market := self defaultMarket.		
	                	
	cartID := self createCartForDefaultUserIn: market.

	self fastForwardMinutes: 25.
	
	market addToCart: cartID book: itemFactory itemSellByTheStore amount: 1.
	
	self fastForwardMinutes: 25.

	self assert: (market listCart: cartID) includes: itemFactory itemSellByTheStore.
! !


!MarketInterfaceTest methodsFor: 'tests - addToCart' stamp: 'js 11/18/2019 11:21:48'!
test07AddingToInvalidCartIDRaisesError

	| market |

	market := self defaultMarket.		
	
	self should: [market addToCart: -12 book: itemFactory itemSellByTheStore amount: 1.] 
		 raise: Error - MessageNotUnderstood 
	      withMessageText: MarketInterface errorNonExistantCart .
	
	! !

!MarketInterfaceTest methodsFor: 'tests - addToCart' stamp: 'A.B. 11/15/2019 22:57:10'!
test12AddingBooksToClosedCartRaisesError

	| market book cartID |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	book := itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 1.
	
	market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	
	self should:  [ market addToCart: cartID book: book amount: 1. ]
	 raise:  Error - MessageNotUnderstood 
	 withExceptionDo: [ :anError | 
		self assert: MarketInterface errorCheckedOutCart equals: anError messageText.
		self assert: 1 equals: (market listCart: cartID) size.
		self assert: 1 equals: ((market listCart: cartID) occurrencesOf: book).
	]
		! !

!MarketInterfaceTest methodsFor: 'tests - addToCart' stamp: 'A.B. 11/15/2019 22:58:12'!
test21AddingBookToExpiredCartRaisesError

	| market cartID |

	market := self defaultMarket.		
	
	cartID := self createCartForDefaultUserIn: market.
	
	self fastForwardMinutes: 30.
	
	self should: [market addToCart: cartID book: itemFactory itemSellByTheStore amount: 3.]  
		 raise: Error -MessageNotUnderstood  
		 withMessageText: market class errorExpiredCart.! !


!MarketInterfaceTest methodsFor: 'tests - checkOutCart' stamp: 'js 11/18/2019 11:23:57'!
test10CheckoutCartWithInvalidIdRaisesError

	| market |

	market := self defaultMarket.		
	
	self should: [ market checkOutCart: -1 withCreditCard: itemFactory notExpiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: MarketInterface errorNonExistantCart equals: anError messageText.
			self assert: (market listPurchasesOf: self defaultUsername withPassword: self defaultUsernamePassword) isEmpty.
		] ! !

!MarketInterfaceTest methodsFor: 'tests - checkOutCart' stamp: 'A.B. 11/15/2019 22:56:50'!
test11DifferentValidCheckoutsGiveDIfferentTransactionIds

	| market book cartID anotherCartID anotherTransactionID transactionID |

	market := self defaultMarket.		
	
	cartID := self createCartForDefaultUserIn: market.
	anotherCartID := market createCartForUser: 'anotherDefaultUser' password:'passwordsupersegura2'.
	
	book := itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 1.
	market addToCart: anotherCartID book: book amount: 3.
	
	transactionID := market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	anotherTransactionID := market checkOutCart: anotherCartID withCreditCard: itemFactory notExpiredCreditCard.
	
	self deny: (transactionID = anotherTransactionID) . ! !

!MarketInterfaceTest methodsFor: 'tests - checkOutCart' stamp: 'A.B. 11/15/2019 22:57:17'!
test13CheckingOutTwiceTheSameCartRaisesError

	| market book cartID |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	book := itemFactory itemSellByTheStore .
	market addToCart: cartID book: itemFactory itemSellByTheStore amount: 1.
	
	market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	
	self should:  [ market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard. ]
	 raise:  Error - MessageNotUnderstood 
	 withExceptionDo: [ :anError | 
		self assert: MarketInterface errorCheckedOutCart equals: anError messageText.
		self assert: 1 equals: (market listCart: cartID) size.
		self assert: 1 equals: ((market listCart: cartID) occurrencesOf: book).
	]
		! !

!MarketInterfaceTest methodsFor: 'tests - checkOutCart' stamp: 'A.B. 11/15/2019 22:57:25'!
test14CheckingOutCommunicatesCorrectlyWithMP

	| market cartID mpText |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	market addToCart: cartID book: itemFactory itemSellByTheStore amount: 1.
	
	mpText := 'MP fue utilizado'.
	mpAction := [ :anAmount :aCreditCard | self error: mpText ].
	
	self should:  [ market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard. ]
		 raise:  Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError | self assert: mpText equals: anError messageText.].

	mpAction := [ :anAmount :aCreditCard | ].

		! !

!MarketInterfaceTest methodsFor: 'tests - checkOutCart' stamp: 'js 11/18/2019 11:24:48'!
test23CheckOutOnExpiredCartRaisesError

	| market cartID |

	market := self defaultMarket.		
	                	
	cartID := self createCartForDefaultUserIn: market.
	
	market addToCart: cartID book: itemFactory itemSellByTheStore amount: 1.
	
	self fastForwardMinutes: 30.

	self should: [market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.]  
		 raise: Error - MessageNotUnderstood  
		 withMessageText: market class errorExpiredCart.! !


!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:08:11'!
test15ListingPurchasesOfInvalidUserRaisesError

	| market |

	market := self defaultMarket.		
                          		
	self should:  [ market listPurchasesOf: 'notAUser' withPassword: self defaultUsernamePassword . ]
	 raise:  Error - MessageNotUnderstood 
	 withExceptionDo: [ :anError | 
		self assert: MarketInterface errorInvalidUser equals: anError messageText.
	].

		! !

!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:08:32'!
test16ListingPurchasesWithInvalidPasswordRaisesError

	| market |

	market := self defaultMarket.		
                            	
	self should:  [ market listPurchasesOf: self defaultUsername withPassword:'password-invalid'. ]
	 raise:  Error - MessageNotUnderstood 
	 withExceptionDo: [ :anError | 
			self assert: MarketInterface errorInvalidPassword equals: anError messageText. ].

		! !

!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:08:55'!
test17ListPurchasesOfNewUserIsEmpty

	| market list |

	market := self defaultMarket.		
                            	
	list := market listPurchasesOf: self defaultUsername  withPassword: self defaultUsernamePassword . 
	
	self assert: list isEmpty .
		! !

!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:09:18'!
test18ListingOfAUserListsTheCorrectTotal

	| market list cartID |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	market addToCart: cartID book: itemFactory itemSellByTheStore amount: 1.	
	
	market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	
	list := market listPurchasesOf: self defaultUsername withPassword: self defaultUsernamePassword .
	
	self assert: 10 equals: list total.
! !

!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:09:41'!
test19DifferentUsersHaveDifferentPurchasesList

	| market book cartID anotherCartID list |

	market := self defaultMarket.		
	
	cartID := self createCartForDefaultUserIn: market.
	anotherCartID := market createCartForUser: 'anotherDefaultUser' password:'passwordsupersegura2'.
	
	book := itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 1.
	market addToCart: anotherCartID book: book amount: 3.
	
	market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	market checkOutCart: anotherCartID withCreditCard: itemFactory notExpiredCreditCard.
	
	list := market listPurchasesOf: self defaultUsername withPassword: self defaultUsernamePassword .
	anotherList := market listPurchasesOf: 'anotherDefaultUser' withPassword: 'passwordsupersegura2'.
	
	self deny: (list = anotherList). 
	! !

!MarketInterfaceTest methodsFor: 'tests - listPurchases' stamp: 'A.B. 11/15/2019 23:10:02'!
test20ListingOfAUserListsTheCorrectBooksAndAmounts

	| market list book cartID |

	market := self defaultMarket.		
	                            	
	cartID := self createCartForDefaultUserIn: market.
	
	book := itemFactory itemSellByTheStore .
	market addToCart: cartID book: book amount: 3.	
	
	market checkOutCart: cartID withCreditCard: itemFactory notExpiredCreditCard.
	
	list := market listPurchasesOf: self defaultUsername withPassword: self defaultUsernamePassword .
	
	self assert: 3 equals: (list count: book).
! !


!classDefinition: #Cart category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
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


!Cart methodsFor: 'total' stamp: 'A.B 11/7/2019 20:05:59'!
listItems

	^ OrderedCollection newFrom: items .! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'A.B. 11/16/2019 13:46:48'!
pvtCalculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'A.B. 11/16/2019 13:47:03'!
pvtDebitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'A.B. 11/16/2019 13:47:14'!
pvtRegisterSale

	salesBook add: (Sale ofItems: cart listItems withTotal: cart total).! !


!Cashier methodsFor: 'checkout' stamp: 'A.B. 11/16/2019 13:47:14'!
checkOut

	self pvtCalculateTotal.
	self pvtDebitTotal.
	self pvtRegisterSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MarketInterface category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #MarketInterface
	instanceVariableNames: 'currentID cartsByID userPasswords priceList currentTransactionID checkedOutCarts merchantProcessor timeGuru salesBooks cartIdOwners cartLastUsageTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketInterface methodsFor: 'protocol' stamp: 'js 11/18/2019 11:16:28'!
addToCart: aCartID book: aBook amount: anAmount

	| cart |
	
	cart := self pvtGetValidCartAndUpdateIt: aCartID.
	
	cart add: anAmount of: aBook. ! !

!MarketInterface methodsFor: 'protocol' stamp: 'js 11/18/2019 11:16:34'!
checkOutCart: aCartID withCreditCard: aCreditCard

	| cart cashier cartOwner |
	
	cart := self pvtGetValidCartAndUpdateIt: aCartID.
	
	cartOwner := cartIdOwners at: aCartID.
	
	cashier := Cashier 
		toCheckout: cart 
		charging: aCreditCard
		throught: merchantProcessor
		on: timeGuru dateAndTime 
		registeringOn: (salesBooks at: cartOwner).
	
	cashier checkOut.
	
	checkedOutCarts add: aCartID.
	
	currentTransactionID := currentTransactionID + 1.
	^ currentTransactionID.

	
	

! !

!MarketInterface methodsFor: 'protocol' stamp: 'A.B. 11/16/2019 13:35:22'!
createCartForUser: aUser password: aPassword 
	
	| cart |

	self pvtAutenticateUser: aUser password: aPassword. 
	
	cart := Cart acceptingItemsOf: priceList.
	
	self pvtSaveCart: cart of: aUser.
	
	^ currentID.! !

!MarketInterface methodsFor: 'protocol' stamp: 'js 11/18/2019 11:06:23'!
listCart: aCartID 

	| cart |
	
	cart := self pvtGetCartFromID: aCartID.
		
	self pvtAssertCartIDIsNotExpired: aCartID .
	self pvtUpdateLastUsageTimeOfCart: aCartID.

	^ cart listItems .! !

!MarketInterface methodsFor: 'protocol' stamp: 'js 11/18/2019 10:47:13'!
listPurchasesOf: aUser withPassword: aPassword

	self pvtAutenticateUser: aUser password: aPassword .
		
	^ salesBooks at: aUser.! !


!MarketInterface methodsFor: 'assertions - private' stamp: 'js 11/18/2019 10:43:47'!
pvtAssertCartIDIsNotExpired: aCartID
	
	| creationTime nowTime |
	
	nowTime := timeGuru dateAndTime.
	creationTime := cartLastUsageTime at: aCartID .
	
	((nowTime - creationTime ) >= (Duration minutes: 30))  ifTrue: [self error: self class errorExpiredCart ].
	! !

!MarketInterface methodsFor: 'assertions - private' stamp: 'A.B. 11/16/2019 13:28:48'!
pvtAssertCartIsNotCheckedOut: aCartID
		
	(checkedOutCarts includes: aCartID) ifTrue: [ self error: self class errorCheckedOutCart ].
! !

!MarketInterface methodsFor: 'assertions - private' stamp: 'A.B. 11/16/2019 12:48:52'!
pvtAutenticateUser: aUser password: aPassword 
	
	| savedPassword |

	savedPassword := userPasswords at: aUser ifAbsent: [ ^ self error: self class errorInvalidUser ].  
	
	(savedPassword = aPassword) ifFalse: [ ^ self error: self class errorInvalidPassword ].
! !

!MarketInterface methodsFor: 'assertions - private' stamp: 'js 11/18/2019 11:15:40'!
pvtGetValidCartAndUpdateIt: aCartID

	| cart |

	cart := self pvtGetCartFromID: aCartID.
	
	self pvtAssertCartIDIsNotExpired: aCartID .
	self pvtAssertCartIsNotCheckedOut: aCartID .
	self pvtUpdateLastUsageTimeOfCart: aCartID.
	
	^ cart.! !


!MarketInterface methodsFor: 'cart storage - private' stamp: 'A.B. 11/16/2019 13:33:02'!
pvtAvailableID
	
	currentID := currentID + 1.
	
	^ currentID ! !

!MarketInterface methodsFor: 'cart storage - private' stamp: 'A.B. 11/16/2019 13:39:20'!
pvtGetCartFromID: aCartID
	
	^ cartsByID at: aCartID ifAbsent: [ self error: self class errorNonExistantCart. ].
	! !

!MarketInterface methodsFor: 'cart storage - private' stamp: 'js 11/18/2019 10:44:16'!
pvtSaveCart: aCart of: aUser
	
	| cartID |
	
	cartID := self pvtAvailableID .
	
	cartsByID at: cartID put: aCart .
	cartIdOwners at: cartID put: aUser. 
	
	self pvtUpdateLastUsageTimeOfCart: cartID.
	! !

!MarketInterface methodsFor: 'cart storage - private' stamp: 'js 11/18/2019 10:43:47'!
pvtUpdateLastUsageTimeOfCart: cartID

	cartLastUsageTime at: cartID put: timeGuru dateAndTime.
	! !


!MarketInterface methodsFor: 'initialization' stamp: 'js 11/18/2019 10:43:47'!
initializeWithPasswords: someUserPasswords withPriceList: aPriceList withMP: aMP withTimeGuru: aTimeGuru   

	currentID := 0.
	cartsByID := Dictionary new.
	currentTransactionID := 0.
	checkedOutCarts := OrderedCollection new.
	userPasswords := someUserPasswords.
	priceList := aPriceList.
	cartIdOwners := Dictionary new.
	merchantProcessor := aMP.
	timeGuru := aTimeGuru.
	salesBooks := Dictionary new.
	userPasswords keys do: [ :aUser |
		salesBooks at: aUser put: SalesBook new.	
	].
	cartLastUsageTime := Dictionary new.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarketInterface class' category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
MarketInterface class
	instanceVariableNames: ''!

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B 11/11/2019 18:56:52'!
errorCheckedOutCart

	^ 'Cart was checked out previously.'! !

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B. 11/15/2019 20:25:18'!
errorExpiredCart

	^ 'The cart has not been used in thirty minutes. Please create a new one.'! !

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B 11/7/2019 20:33:09'!
errorInvalidBook

	^ 'We dont sell this book.'! !

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B 11/11/2019 17:53:03'!
errorInvalidPassword

	^ 'Invalid password'! !

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B 11/11/2019 18:04:38'!
errorInvalidUser

	^ 'Invalid user'! !

!MarketInterface class methodsFor: 'error messages' stamp: 'A.B 11/7/2019 20:18:41'!
errorNonExistantCart

	^ 'This cart does not exist!!'! !


!MarketInterface class methodsFor: 'instance creation' stamp: 'A.B 11/11/2019 19:16:27'!
withUserPasswords: someUserPasswords withPriceList: aPriceList withMP: aMP withTimeGuru: aTimeGuru   

	^ self new initializeWithPasswords: someUserPasswords withPriceList: aPriceList withMP: aMP withTimeGuru: aTimeGuru.

	! !


!classDefinition: #Sale category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'js 11/14/2019 13:53:06'!
count: anElementToCount
	
	^ items count: [ :anElem | anElem = anElementToCount ].
! !

!Sale methodsFor: 'total' stamp: 'js 11/14/2019 13:37:24'!
items
	
	^ items ! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'js 11/18/2019 11:19:44'!
initializeItems: cartItems withTotal: aTotal. 

	total := aTotal.
	items := cartItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'js 11/18/2019 11:18:57'!
ofItems: cartItems withTotal: aTotal

	^ self new initializeItems: cartItems withTotal: aTotal. ! !


!classDefinition: #SalesBook category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'adding' stamp: 'js 11/14/2019 13:32:18'!
add: aSale

	sales add: aSale.
	! !


!SalesBook methodsFor: 'intitialization' stamp: 'js 11/13/2019 14:11:46'!
initialize
	
	total := 0.
	sales := OrderedCollection new.! !


!SalesBook methodsFor: 'accessing' stamp: 'js 11/14/2019 13:52:46'!
count: anElementToCount

	^ sales sum: [ :aSale | 
		aSale count: anElementToCount
	].
! !

!SalesBook methodsFor: 'accessing' stamp: 'js 11/13/2019 13:46:48'!
isEmpty

	^ sales isEmpty.! !

!SalesBook methodsFor: 'accessing' stamp: 'js 11/14/2019 13:34:26'!
size

	^ sales size
! !

!SalesBook methodsFor: 'accessing' stamp: 'js 11/14/2019 13:33:19'!
total

	^ sales sum: [ :aSale | aSale total ]
! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'js 11/18/2019 11:28:25'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
