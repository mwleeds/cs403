Object subclass: #A.
A extend [
	p [^1]
	q [^-1]
]

myA := A new.
Transcript display: (myA p); cr.
Transcript display: (myA q); cr.

A subclass: #B.
B extend [
	p [^2]
	q [^self p]
]

myB := B new.
Transcript display: (myB p); cr.
Transcript display: (myB q); cr.

B subclass: #C.

C extend [
	p [^3]
]

myC := C new.
Transcript display: (myC q); cr.

