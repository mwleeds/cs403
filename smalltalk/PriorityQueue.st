Object subclass: #Node.
Node instanceVariableNames: 'data next'.
Node extend [
	data [^data]
	next [^next]
	data: d [data:=d]
	next: n [next:=n]
]

Object subclass: #Queue.
Queue instanceVariableNames: 'front back'.
Queue extend [
    insert: key [                              "enqueue"
        | p |
        p:=Node new data: key.
        front isNil
            ifTrue: [front:=p. back:=p]
            ifFalse: [back next: p. back:=p]
    ]
    remove [                                   "dequeue"
        | key |
        front isNil ifTrue: [^nil].
        key:=front data.
        front:=front next.
        ^key
    ]
    display [
        | p |
        p:=front.
        [p notNil] whileTrue: [Transcript display: p data; cr. p:=p next]
   ]
]

q:=Queue new.
q insert: 20; insert: 40; insert: 10; insert: 30.
1 to: 5 do: [:k | Transcript display: q remove; cr].
Transcript cr.

Queue extend [
    do: aBlock [                              
        | p |
        p:=front.
        [p notNil] whileTrue: [aBlock value: p data. p:=p next]
    ]
    collect: aBlock [                                   
        | q |
        q := self class new.
        self do: [:key | q insert: (aBlock value: key)].
        ^q
    ]
]

q:=Queue new.
q insert: 20; insert: 40; insert: 10; insert: 30.
q do: [:x | Transcript display: x; cr].
Transcript cr.

r:=q collect: [:x | x*x].
r do: [:x | Transcript display: x; cr].
Transcript cr.

Queue extend [
    select: aBlock [                              
        | q |
        q := self class new.
        self do: [:key | (aBlock value: key) ifTrue: [q insert: key] ].
        ^q
    ]
    reject: aBlock [                                   
        | q |
        q := self class new.
        self do: [:key | (aBlock value: key) ifFalse: [q insert: key] ].
        ^q
    ]
]

s:=q select: [:x | x>15 and: [x<35] ].
s do: [:x | Transcript display: x; cr].
Transcript cr.

t:=q reject: [:x | x>15 and: [x<35] ].
t do: [:x | Transcript display: x; cr].
Transcript cr.

Queue extend [
    reject: aBlock [                                   
        ^self select: [:x | (aBlock value: x) not]
    ]
]

u:=q reject: [:x | x>15 and: [x<35] ].
u do: [:x | Transcript display: x; cr].
Transcript cr.

Queue extend [
    inject: id into: aBlock [                              
        | x |
        x:=id.
        self do: [:key | x:=aBlock value: x value: key].
        ^x
    ]
    detect: aBlock ifNone: defaultBlock [                                   
        self do: [:key | (aBlock value: key) ifTrue: [^key] ].
        ^defaultBlock value
    ]
]

Transcript display: (q inject: 0 into: [:a :b | a+b]); cr.
Transcript display: (q inject: 1 into: [:a :b | a*b]); cr.
Transcript cr.

Transcript display: (q detect: [:x | x<15] ifNone: [99]); cr.
Transcript display: (q detect: [:x | x>25] ifNone: [99]); cr.
Transcript display: (q detect: [:x | x>50] ifNone: [99]); cr.
Transcript cr.

Queue subclass: #PriorityQueue1.
PriorityQueue1 extend [
    insert: key [
        | p |
        (front isNil or: [key < front data])
            ifTrue: [front:=Node new data: key; next: front. ^self].
        p:=front.
        [p next isNil or: [key < p next data]]
            whileFalse: [p:=p next].
        p next: (Node new data: key; next: p next)
   ]
]

q:=PriorityQueue1 new.
q insert: 20; insert: 40; insert: 10; insert: 30.
1 to: 5 do: [:k | Transcript display: q remove; cr].
Transcript cr.

Queue subclass: #PriorityQueue2.
PriorityQueue2 extend [
    remove [                                    "removeMin"
        | p key |
        front isNil ifTrue: [^nil].
        p:=front.
        key:=front data.
        [p isNil] whileFalse: [
            (p data < key) ifTrue: [key:=p data].
            p:=p next
        ].
        (key == front data) ifTrue: [front:=front next. ^key].
        p:=front.
        [key ~= p next data] whileTrue: [p:=p next].
        p next: p next next.
        ^key
   ]
]

q:=PriorityQueue2 new.
q insert: 20; insert: 40; insert: 10; insert: 30.
1 to: 5 do: [:k | Transcript display: q remove; cr].

