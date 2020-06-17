Class {
	#name : #GtPhpYieldExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expression',
		'key',
		'operator'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpYieldExpression >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	key ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpYieldExpression >> expression [
	^ expression
]

{ #category : #accessing }
GtPhpYieldExpression >> key [
	^ key
]

{ #category : #accessing }
GtPhpYieldExpression >> operator [
	^ operator
]
