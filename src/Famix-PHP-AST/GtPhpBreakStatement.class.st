Class {
	#name : #GtPhpBreakStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpBreakStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpBreakStatement >> expression [
	^ expression
]
