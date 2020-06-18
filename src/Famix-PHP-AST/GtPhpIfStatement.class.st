Class {
	#name : #GtPhpIfStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'falseStatement',
		'condition',
		'trueStatement'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpIfStatement >> children [
	| result |
	result := super children.
	falseStatement ifNotNil: [ :x | result add: x ].
	condition ifNotNil: [ :x | result add: x ].
	trueStatement ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpIfStatement >> condition [
	^ condition
]

{ #category : #accessing }
GtPhpIfStatement >> falseStatement [
	^ falseStatement
]

{ #category : #testing }
GtPhpIfStatement >> isControllerRouteTest [
	^ (self condition isKindOf: GtPhpInfixExpression) and: [
		(self condition left isKindOf: GtPhpVariable) and: [
			(self condition right isKindOf: GtPhpScalar) and: [ 
				self condition left identifier name = 'action' ] ] ]
]

{ #category : #accessing }
GtPhpIfStatement >> trueStatement [
	^ trueStatement
]
