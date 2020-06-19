Class {
	#name : #GtPhpArrayCreation,
	#superclass : #GtPhpVariableBase,
	#traits : 'TGtPhpArrayCreation',
	#classTraits : 'TGtPhpArrayCreation classTrait',
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

{ #category : #accessing }
GtPhpArrayCreation >> elements [
	^ elements
]

{ #category : #accessing }
GtPhpArrayCreation >> hasArrayKey [
	^ hasArrayKey
]

{ #category : #initialization }
GtPhpArrayCreation >> initialize [
	super initialize.
	elements := OrderedCollection new.

]
