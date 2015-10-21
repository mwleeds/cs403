"Author: Matthew Leeds"
"Purpose: Implement a Queue and Deque in Smalltalk"

Object subclass: #Node.
Node instanceVariableNames: 'data next prev'.

Node extend [
	data [^data]
	next [^next]
	prev [^prev]
	data: newData [ data := newData ]
	next: newNext [ next := newNext ]
	prev: newPrev [ prev := newPrev ]
]

"A standard queue follows"

Object subclass: #Queue.
Queue instanceVariableNames: 'front back'.

Queue extend [
	insert: key [
		| p |
		p := Node new data: key.
		front ifNil: [ front := p. back := p.]
			  ifNotNil: [ back next: p. p prev: back. back := p. ]
		
	]
	remove [
		| p |
		front ifNil: [^front]
			  ifNotNil: [ front next ifNotNil: [ front next prev: nil ]. p := front. front := front next. ^p data ]
	]
	do: aBlock [
		| p |
		p := front.
		[ p notNil] whileTrue: [ aBlock value: p data. p := p next ]
	]
	collect: aBlock [
		| q |
		q := self class new.
		self do: [ :x | q insert: (aBlock value: x) ].
		^q
	]
]


"A double-ended queue follows"

Object subclass: #Deque.
Deque instanceVariableNames: 'front back'.

Deque extend [
	insertFront: key [
		| p |
		p := Node new data: key; next: front.
		front ifNil: [ front := p. back := p. ]
			  ifNotNil: [ front prev: p. front := p. ]
	]
	insertBack: key [
		| p |
		p := Node new data: key; prev: back.
		back ifNil: [ back := p. front := p. ]
			 ifNotNil: [ back next: p. back := p. ]
	]
	removeFront [
		| p |
		front ifNil: [^front]
			  ifNotNil: [ 
              	front next ifNil: [ back := nil ] ifNotNil: [ front next prev: nil ]. 
                p := front. 
                front := front next.
				^p
			  ]	
	]
	removeBack [
		| p |
		back ifNil: [^back]
			 ifNotNil: [
			   back prev ifNil: [ front := nil ] ifNotNil: [ back prev next: nil ].
			   p := back.
			   back := back prev.
			   ^p
			 ]
	]
	do: aBlock [
		| p |
		p := front.
		[ p notNil] whileTrue: [ aBlock value: p data. p := p next ]
	]
	collect: aBlock [
		| q |
		q := self class new.
		self do: [ :x | q insertBack: (aBlock value: x) ].
		^q
	]
	print [
		self do: [ :x | Transcript display: x; cr ]
	]
]

