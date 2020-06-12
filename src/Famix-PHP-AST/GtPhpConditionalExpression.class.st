Class {
	#name : #GtPhpConditionalExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'ifFalse',
		'operatorType',
		'condition',
		'ifTrue'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpConditionalExpression >> children [
	| result |
	result := super children.
	ifFalse ifNotNil: [ :x | result add: x ].
	condition ifNotNil: [ :x | result add: x ].
	ifTrue ifNotNil: [ :x | result add: x ].
	^ result
]
