Class {
	#name : #GtPhpArrayCreation,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'hasArrayKey',
		'elements'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArrayCreation >> children [
	| result |
	result := super children.
	result addAll: elements.
	^ result
]

{ #category : #initialization }
GtPhpArrayCreation >> initialize [
	super initialize.
	elements := OrderedCollection new.

]
