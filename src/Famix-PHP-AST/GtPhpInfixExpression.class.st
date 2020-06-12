Class {
	#name : #GtPhpInfixExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'right',
		'left',
		'operator'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpInfixExpression >> children [
	| result |
	result := super children.
	right ifNotNil: [ :x | result add: x ].
	left ifNotNil: [ :x | result add: x ].
	^ result
]
