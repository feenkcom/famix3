Class {
	#name : #GtPhpSwitchCase,
	#superclass : #GtPhpStatement,
	#instVars : [
		'isDefault',
		'actions',
		'value'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpSwitchCase >> children [
	| result |
	result := super children.
	result addAll: actions.	value ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpSwitchCase >> initialize [
	super initialize.
	actions := OrderedCollection new.

]
