Class {
	#name : #GtPhpUnaryOperation,
	#superclass : #GtPhpExpression,
	#instVars : [
		'operator',
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpUnaryOperation >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpUnaryOperation >> expression [
	^ expression
]

{ #category : #accessing }
GtPhpUnaryOperation >> operator [
	^ operator
]
