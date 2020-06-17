Class {
	#name : #GtPhpReference,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpReference >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpReference >> expression [
	^ expression
]
