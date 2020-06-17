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
GtPhpSwitchCase >> actions [
	^ actions
]

{ #category : #accessing }
GtPhpSwitchCase >> children [
	| result |
	result := super children.
	result addAll: actions.
	value ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpSwitchCase >> initialize [
	super initialize.
	actions := OrderedCollection new.

]

{ #category : #accessing }
GtPhpSwitchCase >> isDefault [
	^ isDefault
]

{ #category : #accessing }
GtPhpSwitchCase >> value [
	^ value
]
