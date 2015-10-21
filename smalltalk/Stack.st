"Author: Matthew Leeds"
"Purpose: Implement a Stack in Smalltalk"

Object subclass: #Node.
Node instanceVariableNames: 'data next'.

Node extend [
	data [^data]
	next [^next]
	data: newData [ data := newData ]
	next: newNext [ next := newNext ]
]

Object subclass: #Stack.
Stack instanceVariableNames: 'top'.

Stack extend [
	push: key [
		| p |
		p := Node new data: key; next: top.
		top := p.
	]
	pop [
		| p |
		top ifNil: [^top].
		p := top.
		top := top next.
		^p data
	]
	do: aBlock [
		| p |
		p := top.
		[p notNil] whileTrue: [ aBlock value: p data. p := p next ]
	]
	collect: aBlock [
		| q |
		q := self class new.
		self do: [ :x | q push: (aBlock value: x) ].
		^q
	]
]

