!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 18:27:21'!
* unNumeroDePeano
	
	^ unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 18:50:06'!
+ unNumeroDePeano

	^ unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:30:39'!
- unNumeroDePeano

	Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:22:50'!
/ unNumeroDePeano
	unNumeroDePeano = I ifFalse: [Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^ self.! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 19:44:53'!
< unNumeroDePeano
	
	^ (self = unNumeroDePeano) not! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:31:36'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir por un numero mayor.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:31:41'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Solo se puede operar con numeros positivos '! !

!I class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 18:25:42'!
next

	^ II! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:36:39'!
restaInv: unNumeroDePeano

	^ unNumeroDePeano previous .! !

!I class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 19:21:25'!
timesRepeat: unClosure
	
	unClosure value.! !


!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 18:36:42'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano  + unNumeroDePeano
	
	 ! !

!II class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 18:55:05'!
+ unNumeroDePeano
	
	^ self previous + unNumeroDePeano  next! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:37:29'!
- unNumeroDePeano

	^ unNumeroDePeano restaInv: self 
! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:25:17'!
/ unNumeroDePeano

	| resultado numerador |
	resultado _ I.
	numerador _ self.

	numerador < unNumeroDePeano ifTrue: [ Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	[ unNumeroDePeano < numerador ] whileTrue: [ 
		numerador _ numerador - unNumeroDePeano.
		resultado _ resultado + I.
	].

	numerador = unNumeroDePeano ifTrue: [ resultado _ resultado + I ].
			
	^ resultado previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 19:50:39'!
< unNumeroDePeano
	
	| esMenor |
	self = unNumeroDePeano ifTrue: [ 
		esMenor _ false
	] ifFalse: [
		esMenor _ self previous < unNumeroDePeano 	
	].
	
	^ esMenor ! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:19:50'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^ 'Error: No se puede dividir por un numero mayor.'! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:41:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 19:03:47'!
next
	
	"este next es un colaborador del objeto, no confundir con el metodo next"
	next ifNil: [  
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next! !

!II class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 18:57:59'!
previous
	"no confundir el colaborador con el nombre del metodo"
	^ previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 19:06:43'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'b 8/26/2019 18:41:01'!
removeAllNext


	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:36:14'!
restaInv: unNumeroDePeano
	
	^ self previous restaInv: unNumeroDePeano previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'js 8/27/2019 19:20:49'!
timesRepeat: unClosure

	unClosure value.
	self previous timesRepeat: unClosure.! !


!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano  + unNumeroDePeano
	
	 ! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
+ unNumeroDePeano
	
	^ self previous + unNumeroDePeano  next! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
- unNumeroDePeano

	^ unNumeroDePeano restaInv: self 
! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
/ unNumeroDePeano

	| resultado numerador |
	resultado _ I.
	numerador _ self.

	numerador < unNumeroDePeano ifTrue: [ Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	[ unNumeroDePeano < numerador ] whileTrue: [ 
		numerador _ numerador - unNumeroDePeano.
		resultado _ resultado + I.
	].

	numerador = unNumeroDePeano ifTrue: [ resultado _ resultado + I ].
			
	^ resultado previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
< unNumeroDePeano
	
	| esMenor |
	self = unNumeroDePeano ifTrue: [ 
		esMenor _ false
	] ifFalse: [
		esMenor _ self previous < unNumeroDePeano 	
	].
	
	^ esMenor ! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^ 'Error: No se puede dividir por un numero mayor.'! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:41:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
next
	
	"este next es un colaborador del objeto, no confundir con el metodo next"
	next ifNil: [  
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
previous
	"no confundir el colaborador con el nombre del metodo"
	^ previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
removeAllNext


	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
restaInv: unNumeroDePeano
	
	^ self previous restaInv: unNumeroDePeano previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
timesRepeat: unClosure

	unClosure value.
	self previous timesRepeat: unClosure.! !


!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
* unNumeroDePeano

	^ self previous * unNumeroDePeano  + unNumeroDePeano
	
	 ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
+ unNumeroDePeano
	
	^ self previous + unNumeroDePeano  next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
- unNumeroDePeano

	^ unNumeroDePeano restaInv: self 
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
/ unNumeroDePeano

	| resultado numerador |
	resultado _ I.
	numerador _ self.

	numerador < unNumeroDePeano ifTrue: [ Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	[ unNumeroDePeano < numerador ] whileTrue: [ 
		numerador _ numerador - unNumeroDePeano.
		resultado _ resultado + I.
	].

	numerador = unNumeroDePeano ifTrue: [ resultado _ resultado + I ].
			
	^ resultado previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
< unNumeroDePeano
	
	| esMenor |
	self = unNumeroDePeano ifTrue: [ 
		esMenor _ false
	] ifFalse: [
		esMenor _ self previous < unNumeroDePeano 	
	].
	
	^ esMenor ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^ 'Error: No se puede dividir por un numero mayor.'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:41:41'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
next
	
	"este next es un colaborador del objeto, no confundir con el metodo next"
	next ifNil: [  
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^ next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
previous
	"no confundir el colaborador con el nombre del metodo"
	^ previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
removeAllNext


	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
restaInv: unNumeroDePeano
	
	^ self previous restaInv: unNumeroDePeano previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'js 9/1/2019 10:39:40'!
timesRepeat: unClosure

	unClosure value.
	self previous timesRepeat: unClosure.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!