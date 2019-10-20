!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'balej 10/17/2019 19:38:43'!
test08NewPortfolioBalanceIsCero

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test09BalanceOfPortfolioWithNonCeroBalancedAccount

	| portfolio account |
	
	portfolio := Portfolio new.

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolio addAsset: account.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test10PortfolioTransactionsOneAccount

	| portfolio account deposit |
	
	portfolio := Portfolio new.

	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	portfolio addAsset: account.
	
	self assert: 1 equals: portfolio transactions size .
	self assert: (portfolio transactions includes: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test11PortfolioTransactionsSeveralAccounts

	| portfolio account1 account2 deposit withdraw |
	
	portfolio := Portfolio new.

	account1 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account1.

	account2 := ReceptiveAccount new.
	withdraw := Withdraw register: 50 on: account2.

	portfolio addAsset: account1.
	portfolio addAsset: account2.
	
	self assert: 2 equals: portfolio transactions size .
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test12PortfolioHasRegisteredARegisteredTransaction

	| portfolio account1 deposit |
	
	portfolio := Portfolio new.

	account1 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account1.

	portfolio addAsset: account1.
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test13PortfolioHasNotRegisteredUnregisteredTransaction

	| portfolio account1 account2 withdraw |
	
	portfolio := Portfolio new.

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	withdraw := Withdraw register: 50 on: account2.

	portfolio addAsset: account1.
	
	self deny: (portfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 22:09:25'!
test14NestedPortfolioHasRegistered

	"Obs: Nos dimos cuenta que en los tests 14, 15, 16 tenemos codigo repetido en la creacion de portfolios,
	decidimos no extraerlo porque necesitabamos refereciar a los portfolios internos en los asserts"

	| portfolio1 portfolio2 portfolio3 portfolio4 account1 deposit |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account1 := ReceptiveAccount new.

	deposit := Deposit register: 50 on: account1.

	portfolio1 addAsset: portfolio2.
	portfolio1 addAsset: portfolio3.
	portfolio2 addAsset: portfolio4.
	
	portfolio4 addAsset: account1.
			
	self assert: (portfolio1 hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test15NestedPortfolioBalance

	| portfolio1 portfolio2 portfolio3 portfolio4 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account1 := ReceptiveAccount new.

	Deposit register: 100 on: account1.

	portfolio1 addAsset: portfolio2.
	portfolio1 addAsset: portfolio3.
	portfolio2 addAsset: portfolio4.
	
	portfolio4 addAsset: account1.
			
	self assert: 100 equals: portfolio1 balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 22:06:33'!
test16NestedPortfolioTransactions

	| portfolio1 portfolio2 portfolio3 portfolio4 account1 deposit |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account1 := ReceptiveAccount new.

	deposit := Deposit register: 100 on: account1.

	portfolio1 addAsset: portfolio2.
	portfolio1 addAsset: portfolio3.
	portfolio2 addAsset: portfolio4.
	
	portfolio4 addAsset: account1.
				
	self assert: 1 equals: portfolio1 transactions size .
	self assert: (portfolio1 transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test17CannotAddDuplicateAccount

	| portfolio1 account1 |
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolio1 addAsset: account1.
				
	self should: [ portfolio1 addAsset: account1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio errorDuplicateAsset equals: anError messageText.
			self assert: 100 equals: portfolio1 balance.			
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test18CannotAddDuplicatePortfolio

	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolio1 addAsset: account1.
	portfolio1 addAsset: portfolio2.
				
	self should: [ portfolio1 addAsset: portfolio2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio errorDuplicateAsset equals: anError messageText.
			self assert: 100 equals: portfolio1 balance.			
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test19CannotAddPortfolioThatAddsCycle

"
       P1
    /      \
P2       P3
  \         /NO
   \      /
    P4
 
"
	| portfolio1 portfolio2 portfolio3 portfolio4 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	portfolio1 addAsset: portfolio2.
	portfolio1 addAsset: portfolio3.
	portfolio2 addAsset: portfolio4.
	
	self should: [ portfolio3 addAsset: portfolio4.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: Portfolio errorDuplicateAsset equals: anError messageText.
	].! !

!PortfolioTest methodsFor: 'tests' stamp: 'js 10/19/2019 21:06:17'!
test20CannotAddIncludedSubportfolio

"
P1       P2
    \      /    \
     A1        P3
                    | NO
                    | 
                   P1
                   |
                   A1

"

	| portfolio1 portfolio2 portfolio3 a1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	a1 := ReceptiveAccount new.

	portfolio1 addAsset: a1.
	portfolio2 addAsset: a1.
	portfolio2 addAsset: portfolio3 .

	
	self should: [ portfolio3 addAsset: portfolio1 .]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: Portfolio errorDuplicateAsset equals: anError messageText.
	].! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'A.B. 10/19/2019 19:10:08'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'balej 10/17/2019 19:46:43'!
valueForBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'js 10/19/2019 21:41:42'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerTransaction: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'balej 10/17/2019 19:46:50'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'balej 10/17/2019 19:46:58'!
valueForBalance

	^ -1 * value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'assetsOwners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'adding' stamp: 'js 10/19/2019 21:06:17'!
addAsset: anAsset

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'balance' stamp: 'js 10/19/2019 20:44:44'!
balance

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'initialization' stamp: 'js 10/19/2019 20:46:13'!
initialize

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'owners' stamp: 'js 10/19/2019 22:43:15'!
addOwner: anAsset

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'owners' stamp: 'js 10/19/2019 22:37:38'!
firstLevelAssets

	| firstLevelAssets |

	firstLevelAssets := OrderedCollection new.
	
	assetsOwners do: [ :anAsset | firstLevelAssets addAll: anAsset firstLevelAssets ].
	
	assetsOwners ifEmpty: [ firstLevelAssets add: self ].
	
	^ firstLevelAssets.! !


!FinancialAsset methodsFor: 'testing' stamp: 'js 10/19/2019 21:48:25'!
hasRegistered: aTransaction

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'testing' stamp: 'js 10/19/2019 21:44:28'!
includesAsset: anAsset

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'testing' stamp: 'js 10/19/2019 22:24:58'!
isIncludedInAsset: anAsset

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'transactions' stamp: 'js 10/19/2019 21:41:42'!
registerTransaction: aTransaction

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'transactions' stamp: 'js 10/19/2019 20:47:44'!
transactions

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'portfolioContents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'js 10/19/2019 22:43:15'!
addAsset: anAsset

	self assertAddingAssetIsValid: anAsset.
	portfolioContents add: anAsset .
	anAsset addOwner: self.! !


!Portfolio methodsFor: 'assertions private' stamp: 'js 10/19/2019 22:39:38'!
assertAddingAssetIsValid: assetToVerify

	(self firstLevelAssets anySatisfy: [ :aFirstLevelAsset | assetToVerify isIncludedInAsset: aFirstLevelAsset ]) 
			ifTrue: [ self error: self class errorDuplicateAsset ].
	
! !


!Portfolio methodsFor: 'balance' stamp: 'js 10/19/2019 21:00:33'!
balance
	
	^ portfolioContents sum: [ :anAsset | anAsset balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'initialization' stamp: 'js 10/19/2019 22:37:38'!
initialize

	portfolioContents := OrderedCollection new.
	assetsOwners := OrderedCollection new.

! !


!Portfolio methodsFor: 'owners' stamp: 'js 10/19/2019 22:43:15'!
addOwner: anAsset

	assetsOwners add: anAsset .! !


!Portfolio methodsFor: 'testing' stamp: 'js 10/19/2019 21:01:25'!
hasRegistered: aTransaction

	^ portfolioContents anySatisfy: [ :portfolioAsset | portfolioAsset hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'testing' stamp: 'js 10/19/2019 22:46:16'!
includesAsset: anAssetToVerify

	^ (self = anAssetToVerify) 
		or: [ portfolioContents anySatisfy: [ :portfolioAsset | portfolioAsset includesAsset: anAssetToVerify ] ]. ! !

!Portfolio methodsFor: 'testing' stamp: 'js 10/19/2019 22:47:16'!
isIncludedInAsset: anAsset

	^ (anAsset includesAsset: self) 
		or: [ portfolioContents anySatisfy: [ :portfolioAsset | portfolioAsset isIncludedInAsset: anAsset ] ].! !


!Portfolio methodsFor: 'transactions' stamp: 'js 10/19/2019 21:41:42'!
registerTransaction: aTransaction

	self error: self class errorCannotRegisterTransactionToPortfolio.! !

!Portfolio methodsFor: 'transactions' stamp: 'js 10/19/2019 21:02:51'!
transactions
	
	| transactions | 
	
	transactions := OrderedCollection new.
	portfolioContents do: [ :portfolioAsset | transactions addAll: portfolioAsset transactions ].
	
	^ transactions.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'js 10/19/2019 20:54:40'!
errorCannotRegisterTransactionToPortfolio

	^ 'Cannot register transaction in portfolio'! !

!Portfolio class methodsFor: 'error messages' stamp: 'A.B. 10/19/2019 18:54:56'!
errorDuplicateAsset

	^ 'Duplicate asset. Cannot add!!'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'adding' stamp: 'js 10/19/2019 21:06:17'!
addAsset: anAsset

	self error: self class errorCannotAddAssetToReceptiveAccount.
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'balej 10/17/2019 19:48:11'!
balance

	^ transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ].
! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'js 10/19/2019 22:37:38'!
initialize

	transactions := OrderedCollection new.
	assetsOwners := OrderedCollection new.
! !


!ReceptiveAccount methodsFor: 'owners' stamp: 'js 10/19/2019 22:43:15'!
addOwner: anOwner

	assetsOwners add: anOwner .! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'A.B. 10/19/2019 18:58:23'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'A.B. 10/19/2019 18:54:00'!
includesAsset: anAsset

	^ self = anAsset .! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'js 10/19/2019 22:48:29'!
isIncludedInAsset: anAsset

	^ anAsset includesAsset: self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'js 10/19/2019 21:41:42'!
registerTransaction: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error messages' stamp: 'js 10/19/2019 20:53:17'!
errorCannotAddAssetToReceptiveAccount

	^ 'Cannot add FinancialAsset to ReceptiveAccount'! !
