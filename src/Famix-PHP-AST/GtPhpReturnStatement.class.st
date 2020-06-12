Class {
	#name : #GtPhpReturnStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpReturnStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
