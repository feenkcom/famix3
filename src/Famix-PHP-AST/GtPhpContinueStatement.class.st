Class {
	#name : #GtPhpContinueStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpContinueStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
