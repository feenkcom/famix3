Class {
	#name : #GtPhpForEachStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'statement',
		'key',
		'value',
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpForEachStatement >> children [
	| result |
	result := super children.
	statement ifNotNil: [ :x | result add: x ].
	key ifNotNil: [ :x | result add: x ].
	value ifNotNil: [ :x | result add: x ].
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpForEachStatement >> expression [
	^ expression
]

{ #category : #accessing }
GtPhpForEachStatement >> key [
	^ key
]

{ #category : #accessing }
GtPhpForEachStatement >> statement [
	^ statement
]

{ #category : #accessing }
GtPhpForEachStatement >> value [
	^ value
]
