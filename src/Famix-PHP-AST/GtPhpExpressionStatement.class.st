Class {
	#name : #GtPhpExpressionStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpExpressionStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
