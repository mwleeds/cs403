"GNU Smalltalk code"

Object subclass: #Pair.
Pair instanceVariableNames: 'x y'.

Pair extend [
    getX [ ^x ]
    getY [ ^y ]
    setX: a [ x := a ]
    setY: b [ y := b ]
].

p := Pair new.
p getX printNl.
p getY printNl.
p setX: 100.
p setY: 'hello'.
p getX printNl.
p getY printNl.


"Here is alternative syntax for defining a new class"
Pair subclass: Triple [
    | z |
	
    getZ [ ^z ]
    setZ: c [ z := c ]
].


t := Triple new setX: 3.14159; setY: $C; setZ: true.
t getX printNl.
t getY printNl.
t getZ printNl.
