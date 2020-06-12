Class {
	#name : #GtPhpWhileStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'body',
		'condition'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpWhileStatement >> children [
	| result |
	result := super children.
	body ifNotNil: [ :x | result add: x ].
	condition ifNotNil: [ :x | result add: x ].
	^ result
]
