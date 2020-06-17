Class {
	#name : #GtPhpArraySpreadElement,
	#superclass : #GtPhpExpression,
	#instVars : [
		'value'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArraySpreadElement >> children [
	| result |
	result := super children.
	value ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpArraySpreadElement >> value [
	^ value
]
