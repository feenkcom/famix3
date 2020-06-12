Class {
	#name : #GtPhpBackTickExpression,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expressions'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpBackTickExpression >> children [
	| result |
	result := super children.
	result addAll: expressions.
	^ result
]

{ #category : #initialization }
GtPhpBackTickExpression >> initialize [
	super initialize.
	expressions := OrderedCollection new.

]
