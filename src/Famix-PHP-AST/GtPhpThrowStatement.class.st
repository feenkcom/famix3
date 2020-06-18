Class {
	#name : #GtPhpThrowStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpThrowStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpThrowStatement >> expression [
	^ expression
]
