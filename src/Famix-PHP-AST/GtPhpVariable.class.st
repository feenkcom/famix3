Class {
	#name : #GtPhpVariable,
	#superclass : #GtPhpVariableBase,
	#traits : 'TGtPhpVariable',
	#classTraits : 'TGtPhpVariable classTrait',
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
GtPhpVariable >> identifier [
	^ identifier
]

{ #category : #accessing }
GtPhpVariable >> isDollared [
	^ isDollared
]
