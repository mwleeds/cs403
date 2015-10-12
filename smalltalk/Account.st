Object subclass: #Account.
Account instanceVariableNames: 'balance'.
Account addClassVarName: 'Total'.
Account class instanceVariableNames: 'Subtotal'.

Account extend [
	open: b [balance:=b. Total:=Total+b. self class addSubtotal: b]
	getBalance [^balance]
]

Account class extend [
	new [ 
		Total isNil ifTrue: [Total:=0].
		Subtotal isNil ifTrue: [Subtotal:=0].
		^super new
	]
	addSubtotal: b [Subtotal:=Subtotal+b]
	getTotal [^Total]
	getSubtotal [^Subtotal]
]

Account subclass: #CheckingAccount.
CheckingAccount extend [
]

Account subclass: #SavingsAccount.
SavingsAccount extend [
]

a1 := Account new open: 100.
a2 := Account new open: 200.
c1 := CheckingAccount new open: 400.
c2 := CheckingAccount new open: 500.
s1 := SavingsAccount new open: 700.
s2 := SavingsAccount new open: 800.

a1 getBalance printNl.
a2 getBalance printNl.
c1 getBalance printNl.
c2 getBalance printNl.
s1 getBalance printNl.
s2 getBalance printNl.

Transcript cr.

Account getTotal printNl.
Account getSubtotal printNl.
CheckingAccount getTotal printNl.
CheckingAccount getSubtotal printNl.
SavingsAccount getTotal printNl.
SavingsAccount getSubtotal printNl.

"
100
200
400
500
700
800

2700
300
2700
900
2700
1500
"
