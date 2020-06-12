Class {
	#name : #GtPhpForStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'conditions',
		'body',
		'initializations',
		'increasements'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpForStatement >> children [
	| result |
	result := super children.
	result addAll: increasements.
	result addAll: conditions.
	body ifNotNil: [ :x | result add: x ].
	result addAll: initializations.
	^ result
]

{ #category : #accessing }
GtPhpForStatement >> initialize [
	super initialize.
	increasements := OrderedCollection new.
	conditions := OrderedCollection new.
	initializations := OrderedCollection new.

]
