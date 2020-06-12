Class {
	#name : #GtPhpTraitPrecedence,
	#superclass : #GtPhpExpression,
	#instVars : [
		'trList',
		'methodReference'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitPrecedence >> children [
	| result |
	result := super children.
	result addAll: trList.	methodReference ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpTraitPrecedence >> initialize [
	super initialize.
	trList := OrderedCollection new.

]
