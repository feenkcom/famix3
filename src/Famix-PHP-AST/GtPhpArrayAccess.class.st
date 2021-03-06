Class {
	#name : #GtPhpArrayAccess,
	#superclass : #GtPhpVariable,
	#traits : 'TGtPhpArrayAccess',
	#classTraits : 'TGtPhpArrayAccess classTrait',
	#instVars : [
		'index',
		'type'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArrayAccess >> children [
	| result |
	result := super children.
	index ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpArrayAccess >> index [
	^ index
]

{ #category : #accessing }
GtPhpArrayAccess >> type [
	^ type
]
