Class {
	#name : #GtPhpTraitPrecedenceStatement,
	#superclass : #GtPhpTraitStatement,
	#instVars : [
		'precedence'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitPrecedenceStatement >> children [
	| result |
	result := super children.
	precedence ifNotNil: [ :x | result add: x ].
	^ result
]
