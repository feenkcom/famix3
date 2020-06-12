Class {
	#name : #GtPhpInstanceOfExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'className',
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpInstanceOfExpression >> children [
	| result |
	result := super children.
	className ifNotNil: [ :x | result add: x ].
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
