Class {
	#name : #GtPhpIfStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'falseStatement',
		'condition',
		'trueStatement'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpIfStatement >> children [
	| result |
	result := super children.
	falseStatement ifNotNil: [ :x | result add: x ].
	condition ifNotNil: [ :x | result add: x ].
	trueStatement ifNotNil: [ :x | result add: x ].
	^ result
]
