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
GtPhpCatchClause >> children [
	| result |
	result := super children.
	body ifNotNil: [ :x | result add: x ].
	result addAll: classNames.	variable ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpCatchClause >> initialize [
	super initialize.
	classNames := OrderedCollection new.

]
