Class {
	#name : #GtPhpInfixExpression,
	#superclass : #GtPhpExpression,
	#traits : 'TGtPhpInfixExpression',
	#classTraits : 'TGtPhpInfixExpression classTrait',
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

{ #category : #accessing }
GtPhpInfixExpression >> left [
	^ left
]

{ #category : #accessing }
GtPhpInfixExpression >> operator [
	^ operator
]

{ #category : #accessing }
GtPhpInfixExpression >> right [
	^ right
]
