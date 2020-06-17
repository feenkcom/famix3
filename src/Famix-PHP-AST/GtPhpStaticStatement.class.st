Class {
	#name : #GtPhpStaticStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expressions'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpStaticStatement >> children [
	| result |
	result := super children.
	result addAll: expressions.
	^ result
]

{ #category : #accessing }
GtPhpStaticStatement >> expressions [
	^ expressions
]

{ #category : #initialization }
GtPhpStaticStatement >> initialize [
	super initialize.
	expressions := OrderedCollection new.

]
