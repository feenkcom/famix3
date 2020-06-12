Class {
	#name : #GtPhpInclude,
	#superclass : #GtPhpExpression,
	#instVars : [
		'includeType',
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpInclude >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
