Class {
	#name : #GtPhpMethodInvocation,
	#superclass : #GtPhpDispatch,
	#instVars : [
		'property'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpMethodInvocation >> children [
	| result |
	result := super children.
	property ifNotNil: [ :x | result add: x ].
	^ result
]
