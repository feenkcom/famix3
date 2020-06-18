Class {
	#name : #GtPhpCatchClause,
	#superclass : #GtPhpStatement,
	#instVars : [
		'body',
		'classNames',
		'variable'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpCatchClause >> body [
	^ body
]

{ #category : #accessing }
GtPhpCatchClause >> children [
	| result |
	result := super children.
	body ifNotNil: [ :x | result add: x ].
	result addAll: classNames.
	variable ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpCatchClause >> classNames [
	^ classNames
]

{ #category : #initialization }
GtPhpCatchClause >> initialize [
	super initialize.
	classNames := OrderedCollection new.

]

{ #category : #accessing }
GtPhpCatchClause >> variable [
	^ variable
]
