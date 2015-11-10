"Author: Matthew Leeds"
"Purpose: Implement a Binary Search Tree in Smalltalk"

Object subclass: #Node.
Node instanceVariableNames: 'left right parent value'.

Node extend [
	left [^left]
	right [^right]
	parent [^parent]
	value [^value]
	left: newLeft [ left := newLeft ]
	right: newRight [ right := newRight ]
	parent: newParent [ parent := newParent ]
	value: newValue [ value := newValue ]
]

Object subclass: #BinaryTree.
BinaryTree instanceVariableNames: 'root'.

BinaryTree extend [
	insert: key [
		| p v |
		p := Node new value: key.
		root ifNil: [ root := p ]
		     ifNotNil: [ 
				v := root. 
				[v notNil] whileTrue: [
					(key < v value) ifTrue: [ v left ifNil: [v left: p. p parent: v. v := nil ]
                                                     ifNotNil: [ v := v left ] ]
    					            ifFalse: [ v right ifNil: [ v right: p. p parent: v. v := nil ]
											           ifNotNil: [ v := v right ] ]
					]
			 ]
	]
	remove: key [
		| v |
		v := root.
		(key ~= v value) whileTrue: [ (key < v value) ifTrue: [ v left ifNil: [^nil]. v := v left. ]
													  ifFalse: [ v right ifNil: [^nil]. v := v right. ]
							]
		((v left isNil) & (v right isNil)) ifTrue: [ (v parent left value = key) ifTrue: [ v parent left: nil ] ifFalse: [ v parent right: nil ] ]
										   ifFalse: [ (v left isNil) ifTrue: [ (v parent left value = key) ifTrue: [ v parent left: v right ] ifFalse: [ v parent right: v right ] ]
																	 ifFalse: [ (v right isNil) [.................................................
	]
	includes: key []
	printPreorder []
	printInorder []
	printPostorder []
]

myBST := BinaryTree new.
myBST insert: 1.
myBST insert: 2.
