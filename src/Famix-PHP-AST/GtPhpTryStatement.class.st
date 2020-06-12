Class {
	#name : #GtPhpTryStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'finallyClause',
		'tryStatement',
		'catchClauses'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTryStatement >> children [
	| result |
	result := super children.
	finallyClause ifNotNil: [ :x | result add: x ].
	tryStatement ifNotNil: [ :x | result add: x ].
	result addAll: catchClauses.
	^ result
]

{ #category : #initialization }
GtPhpTryStatement >> initialize [
	super initialize.
	catchClauses := OrderedCollection new.

]
