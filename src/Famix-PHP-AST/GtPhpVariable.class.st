Class {
	#name : #GtPhpVariable,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'isDollared',
		'identifier'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpVariable >> children [
	| result |
	result := super children.
	identifier ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpVariable >> isDollared [
	^ isDollared
]

{ #category : #accessing }
GtPhpVariable >> name [
	^ identifier
]
