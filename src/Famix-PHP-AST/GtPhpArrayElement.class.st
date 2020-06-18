Class {
	#name : #GtPhpArrayElement,
	#superclass : #GtPhpExpression,
	#instVars : [
		'value',
		'key'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArrayElement >> children [
	| result |
	result := super children.
	value ifNotNil: [ :x | result add: x ].
	key ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpArrayElement >> key [
	^ key
]

{ #category : #accessing }
GtPhpArrayElement >> value [
	^ value
]
