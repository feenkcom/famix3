Class {
	#name : #GtPhpParenthesisExpression,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpParenthesisExpression >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpParenthesisExpression >> expression [
	^ expression
]
