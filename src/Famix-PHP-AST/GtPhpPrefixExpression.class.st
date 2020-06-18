Class {
	#name : #GtPhpPrefixExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'operator',
		'variable'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpPrefixExpression >> children [
	| result |
	result := super children.
	variable ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpPrefixExpression >> operator [
	^ operator
]

{ #category : #accessing }
GtPhpPrefixExpression >> variable [
	^ variable
]
