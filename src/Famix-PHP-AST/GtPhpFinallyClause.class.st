Class {
	#name : #GtPhpFinallyClause,
	#superclass : #GtPhpStatement,
	#instVars : [
		'body'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFinallyClause >> body [
	^ body
]

{ #category : #accessing }
GtPhpFinallyClause >> children [
	| result |
	result := super children.
	body ifNotNil: [ :x | result add: x ].
	^ result
]
