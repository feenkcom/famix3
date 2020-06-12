Class {
	#name : #GtPhpTraitAlias,
	#superclass : #GtPhpExpression,
	#instVars : [
		'traitMethod',
		'modifier',
		'modifierOffset',
		'functionName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitAlias >> children [
	| result |
	result := super children.
	traitMethod ifNotNil: [ :x | result add: x ].
	functionName ifNotNil: [ :x | result add: x ].
	^ result
]
