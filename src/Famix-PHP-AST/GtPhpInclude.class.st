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

{ #category : #accessing }
GtPhpInclude >> expression [
	^ expression
]

{ #category : #accessing }
GtPhpInclude >> includeType [
	^ includeType
]
