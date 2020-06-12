Class {
	#name : #GtPhpCloneExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpCloneExpression >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
