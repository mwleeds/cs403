Object subclass: #Animal.
Animal instanceVariableNames: 'numLegs'.
Animal addClassVarName: 'numAnimals'.
Animal class instanceVariableNames: 'numAnimalsThisSpecies'.

Animal extend [
	numLegs [^numLegs]
	numLegs: newNumLegs [numLegs := newNumLegs ]
	account [ numAnimals := numAnimals + 1 ]
]

Animal class extend [
	numAnimals [^numAnimals]
	numAnimalsThisSpecies [^numAnimalsThisSpecies]
	new [
		numAnimals ifNil: [ numAnimals := 0 ].
		numAnimalsThisSpecies ifNil: [ numAnimalsThisSpecies := 0 ].
		^super new
	]
]

Animal subclass: #Dog.

myAnimal := Animal new.
myAnimal account.
myDog := Dog new.
myDog account.

Transcript display: (Dog numAnimals); cr.
