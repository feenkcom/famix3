Class {
	#name : #GtPhpQuote,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'expressions',
		'type'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpQuote >> children [
	| result |
	result := super children.
	result addAll: expressions.	^ result
]

{ #category : #initialization }
GtPhpQuote >> initialize [
	super initialize.
	expressions := OrderedCollection new.

]
