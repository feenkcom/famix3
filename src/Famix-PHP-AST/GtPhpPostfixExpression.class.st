Class {
	#name : #GtPhpPostfixExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'operator',
		'variable'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpPostfixExpression >> children [
	| result |
	result := super children.
	variable ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpPostfixExpression >> operator [
	^ operator
]

{ #category : #accessing }
GtPhpPostfixExpression >> variable [
	^ variable
]
