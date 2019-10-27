!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportAccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportAccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:29:52'!
test01SummaryOnEmptyAccount

	| account report |
	account := ReceptiveAccount new.
	
	report := (ReportAccountSummary forAccount: account) value.
	
	self assert: 'Balance = 0' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:30:10'!
test02SummaryOnAccWithDeposit

	| account report |
	account := ReceptiveAccount new.
	Deposit register: 40 on: account .
	
	report := (ReportAccountSummary forAccount: account) value.
	
	self assert: 'Depósito por 40. Balance = 40' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:30:22'!
test03SummaryOnAccWithDifferentDeposit

	| account report |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	
	
	report := (ReportAccountSummary forAccount: account) value.
	
	self assert: 'Depósito por 100. Balance = 100' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:23:54'!
test04SummaryOnAccWithWithdraw

	| account report |
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account .
	
	report := (ReportAccountSummary forAccount: account) value.
	
	self assert: 'Extracción por 100. Balance = -100' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:30:40'!
test05SummaryOnAccWithWithdrawByTransfer

	| account1 report account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to:  account2 withValue:50 .
	
	
	report := (ReportAccountSummary forAccount: account1) value.

	self assert: 'Salida por transferencia de 50. Balance = -50' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:30:50'!
test06SummaryOnAccWithDepositByTransfer

	| account1 report account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to:  account2 withValue:50 .
	
	
	report := (ReportAccountSummary forAccount: account2) value.
	
	self assert: 'Entrada por transferencia de 50. Balance = 50' equals: report .! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:31:01'!
test07SummaryOnAccWithMultipleTransactions

	| account1 report account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 withValue:50 .	
	Deposit register: 80 on: account1.
	Withdraw register: 10 on: account1.
	
	report := (ReportAccountSummary forAccount: account1) value.
	
	self assert: 'Salida por transferencia de 50. Depósito por 80. Extracción por 10. Balance = 20' equals: report .
! !

!ReportAccountSummaryTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:31:15'!
test08SummaryOnPortfolioWithMultipleAccounts

	| account1 report account2 portfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	Transfer from: account1 to: account2 withValue: 50.	
	Deposit register: 80 on: account1.
	Withdraw register: 10 on: account1.
	
	Deposit register: 100 on: account2.
	
	report := (ReportAccountSummary forAccount: portfolio) value.
	
	self assert: 'Salida por transferencia de 50. Depósito por 80. Extracción por 10. Entrada por transferencia de 50. Depósito por 100. Balance = 170' equals: report .
! !


!classDefinition: #ReportTransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:32:14'!
test01AccWithOneDesposit

	| account transferNet |
	account := ReceptiveAccount new.
	
	Deposit register: 40 on: account .
	
	transferNet := (ReportTransferNet forAccount: account) value.
	
	self assert: 'Neto de transferencias = 0' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:32:41'!
test02AccWithOneDepositTransaction

	| origAccount destAccount transferNet |
	origAccount := ReceptiveAccount new.
	destAccount := ReceptiveAccount new.
	Transfer from: origAccount to: destAccount withValue: 47.
	
	transferNet := (ReportTransferNet forAccount: destAccount) value.
	
	self assert: 'Neto de transferencias = 47' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:33:03'!
test03AccWithOneWithdrawTransaction

	| origAccount destAccount transferNet |
	origAccount := ReceptiveAccount new.
	destAccount := ReceptiveAccount new.
	Transfer from: origAccount to: destAccount withValue: 47.
	
	transferNet := (ReportTransferNet forAccount: origAccount) value.
	
	self assert: 'Neto de transferencias = -47' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:33:18'!
test04AccWithOneWithdraw

	| account transferNet |
	account := ReceptiveAccount new.
	Withdraw register: 80 on: account .
	
	transferNet := (ReportTransferNet forAccount: account) value .
	
	self assert: 'Neto de transferencias = 0' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:33:41'!
test05AccWithTransactionAndWithdraw

	| origAccount destAccount transferNet |
	origAccount := ReceptiveAccount new.
	destAccount := ReceptiveAccount new.
	Transfer from: origAccount to: destAccount withValue: 47.
	Withdraw register: 80 on: origAccount .
	
	transferNet := (ReportTransferNet forAccount: origAccount) value.
	
	self assert: 'Neto de transferencias = -47' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:34:05'!
test06AccWithMultipleTransfers

	| origAccount destAccount transferNet |
	origAccount := ReceptiveAccount new.
	destAccount := ReceptiveAccount new.
	Transfer from: origAccount to: destAccount withValue: 40.
	Transfer from: destAccount to: origAccount withValue: 90.
	Withdraw register: 80 on: origAccount .
	
	transferNet := (ReportTransferNet forAccount: origAccount) value .
	
	self assert: 'Neto de transferencias = 50' equals: transferNet .! !

!ReportTransferNetTest methodsFor: 'tests' stamp: 'js 10/26/2019 11:34:29'!
test07PortfolioWithMultipleAccounts

	| account1 transferNet account2 portfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	Transfer from: account1 to: account2 withValue: 50.	
	Deposit register: 80 on: account1.
	Withdraw register: 10 on: account1.
	
	Deposit register: 100 on: account2.
	
	transferNet := (ReportTransferNet forAccount: portfolio) value.
	
	self assert: 'Neto de transferencias = 0' equals: transferNet .
! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'js 10/21/2019 20:44:09'!
test01TransferHasValue

	| aDestinationAcount anOriginAccount transfer |
	
	anOriginAccount := ReceptiveAccount new.
	aDestinationAcount := ReceptiveAccount new.
	transfer := Transfer from: anOriginAccount to: aDestinationAcount withValue: 100.
	
	self assert: 100 equals: (transfer value). ! !

!TransferTest methodsFor: 'tests' stamp: 'js 10/21/2019 20:44:31'!
test02TransferHasDifferentValue

	| aDestinationAcount anOriginAccount transfer |
	
	anOriginAccount := ReceptiveAccount new.
	aDestinationAcount := ReceptiveAccount new.
	transfer := Transfer from: anOriginAccount to: aDestinationAcount withValue: 200.
	
	self assert: 200 equals: (transfer value). ! !

!TransferTest methodsFor: 'tests' stamp: 'js 10/21/2019 20:45:04'!
test03TransferPartsAreRegisteredByAccounts

	| aDestinationAcount anOriginAccount aTransfer |
	
	anOriginAccount := ReceptiveAccount new.
	aDestinationAcount := ReceptiveAccount new.
	aTransfer := Transfer from: anOriginAccount to: aDestinationAcount withValue: 200.
	
	self assert: (aDestinationAcount hasRegistered: aTransfer deposit).
	self assert: (anOriginAccount hasRegistered: aTransfer withdraw).
! !

!TransferTest methodsFor: 'tests' stamp: 'js 10/21/2019 20:45:19'!
test04TransfersAffectsAccountBalanceCorrectly

	| aDestinationAcount anOriginAccount aTransfer |
	
	anOriginAccount := ReceptiveAccount new.
	aDestinationAcount := ReceptiveAccount new.
	aTransfer := Transfer from: anOriginAccount to: aDestinationAcount withValue: 200.
	
	self assert: 200 equals: (aDestinationAcount balance).
	self assert: -200 equals: (anOriginAccount balance).
! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'js 10/26/2019 11:19:42'!
transactionsInject: startingValue into: aClosure

	^ self transactions inject: startingValue into: aClosure.! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'js 10/21/2019 19:50:16'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'js 10/21/2019 20:41:42'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'js 10/26/2019 11:57:56'!
valueForReport: aReport

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'js 10/26/2019 11:57:56'!
valueForReport: aReport

	^ aReport messageForDepositWithValue: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'value' stamp: 'js 10/21/2019 21:28:09'!
value

	^ transfer value.! !


!TransferDeposit methodsFor: 'balance' stamp: 'js 10/21/2019 20:41:21'!
affectBalance: aBalance

	^ aBalance + transfer value.! !


!TransferDeposit methodsFor: 'transfer' stamp: 'js 10/21/2019 20:34:04'!
setTransfer: aTransfer

	transfer := aTransfer! !


!TransferDeposit methodsFor: 'reports' stamp: 'js 10/26/2019 11:57:56'!
valueForReport: aReport

	^ aReport messageForTransferDepositWithValue: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'js 10/21/2019 20:36:23'!
for: aValue

	^ self new! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'value' stamp: 'js 10/21/2019 21:28:53'!
value

	^ transfer value.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'js 10/21/2019 20:41:21'!
affectBalance: aBalance

	^ aBalance - transfer value.! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'js 10/21/2019 20:34:41'!
setTransfer: aTransfer

	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'reports' stamp: 'js 10/26/2019 11:57:56'!
valueForReport: aReport

	^ aReport messageForTransferWithdrawWithValue: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'js 10/21/2019 20:36:29'!
for: aValue

	^ self new! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'js 10/26/2019 11:57:56'!
valueForReport: aReport

	^ aReport messageForWithdrawWithValue: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'js 10/26/2019 11:10:33'!
initializeForAccount: anAccount 

	account := anAccount .! !


!Report methodsFor: 'value' stamp: 'js 10/26/2019 11:29:04'!
value

	self subclassResponsibility .! !


!Report methodsFor: 'transaction interaction' stamp: 'js 10/26/2019 11:12:08'!
messageForDepositWithValue: aValue

	self subclassResponsibility .! !

!Report methodsFor: 'transaction interaction' stamp: 'js 10/26/2019 11:12:19'!
messageForTransferDepositWithValue: aValue

	self subclassResponsibility .! !

!Report methodsFor: 'transaction interaction' stamp: 'js 10/26/2019 11:12:27'!
messageForTransferWithdrawWithValue: aValue

	self subclassResponsibility .! !

!Report methodsFor: 'transaction interaction' stamp: 'js 10/26/2019 11:12:36'!
messageForWithdrawWithValue: aValue

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'js 10/26/2019 11:11:04'!
forAccount: anAccount

	^ self new initializeForAccount: anAccount .! !


!classDefinition: #ReportAccountSummary category: #'Portfolio-Solucion'!
Report subclass: #ReportAccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportAccountSummary methodsFor: 'account - private' stamp: 'js 10/26/2019 11:26:36'!
accountBalance 
	
	^ 'Balance = ', account balance asString.
! !

!ReportAccountSummary methodsFor: 'account - private' stamp: 'js 10/26/2019 11:57:56'!
accountSummary

	^ (account transactionsInject: '' into: [ :aSummary :transaction | aSummary , (transaction valueForReport: self) ])
! !



!ReportAccountSummary methodsFor: 'value' stamp: 'js 10/26/2019 11:29:34'!
value

	^ self accountSummary , self accountBalance.
! !


!ReportAccountSummary methodsFor: 'transaction interaction' stamp: 'js 10/21/2019 21:21:26'!
messageForDepositWithValue: aValue

	^ 'Depósito por ', aValue asString ,'. '.! !

!ReportAccountSummary methodsFor: 'transaction interaction' stamp: 'A.B. 10/22/2019 18:06:59'!
messageForTransferDepositWithValue: aValue

	^ 'Entrada por transferencia de ', aValue asString ,'. '.! !

!ReportAccountSummary methodsFor: 'transaction interaction' stamp: 'js 10/26/2019 11:37:23'!
messageForTransferWithdrawWithValue: aValue

	^ 'Salida por transferencia de ', aValue asString,'. '.! !

!ReportAccountSummary methodsFor: 'transaction interaction' stamp: 'js 10/21/2019 21:24:24'!
messageForWithdrawWithValue: aValue

	^ 'Extracción por ', aValue asString ,'. '.! !


!classDefinition: #ReportTransferNet category: #'Portfolio-Solucion'!
Report subclass: #ReportTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTransferNet methodsFor: 'account - private' stamp: 'js 10/26/2019 12:04:00'!
accountTransferNet
	
	^ (account transactionsInject: 0 into: [:transferNet :aTransaction | transferNet + (aTransaction valueForReport: self)]) asString.! !



!ReportTransferNet methodsFor: 'value' stamp: 'js 10/26/2019 12:04:00'!
value

	^ 'Neto de transferencias = ', self accountTransferNet.! !


!ReportTransferNet methodsFor: 'transaction interaction' stamp: 'A.B. 10/22/2019 19:42:48'!
messageForDepositWithValue: aValue

	^ 0! !

!ReportTransferNet methodsFor: 'transaction interaction' stamp: 'A.B. 10/22/2019 19:43:06'!
messageForTransferDepositWithValue: aValue

	^ aValue ! !

!ReportTransferNet methodsFor: 'transaction interaction' stamp: 'A.B. 10/22/2019 19:48:55'!
messageForTransferWithdrawWithValue: aValue

	^ aValue * -1.! !

!ReportTransferNet methodsFor: 'transaction interaction' stamp: 'A.B. 10/22/2019 19:50:08'!
messageForWithdrawWithValue: aValue

	^ 0.! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'deposit and withdraw' stamp: 'js 10/21/2019 20:37:41'!
deposit 

	^ deposit ! !

!Transfer methodsFor: 'deposit and withdraw' stamp: 'js 10/21/2019 20:37:49'!
withdraw 

	^ withdraw ! !


!Transfer methodsFor: 'initialization' stamp: 'js 10/21/2019 20:39:26'!
initializeFrom: anOriginAccount to: aDestinationAccount withValue: aValue

	deposit := TransferDeposit register: aValue on: aDestinationAccount.
	deposit setTransfer: self.
	
	withdraw := TransferWithdraw register: aValue on: anOriginAccount.
	withdraw setTransfer: self.

	value := aValue.
! !


!Transfer methodsFor: 'value' stamp: 'js 10/21/2019 19:31:00'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: 'value'!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'js 10/21/2019 19:30:52'!
from: anOriginAccount to: aDestinationAccount withValue: aValue

	^ self new initializeFrom: anOriginAccount to: aDestinationAccount withValue: aValue
	
	! !
