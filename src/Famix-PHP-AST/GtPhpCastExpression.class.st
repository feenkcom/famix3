Class {
	#name : #GtPhpCastExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expression',
		'castType'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpCastExpression >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
