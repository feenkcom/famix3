Class {
	#name : #GtPhpEchoStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expressions'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpEchoStatement >> children [
	| result |
	result := super children.
	result addAll: expressions.
	^ result
]

{ #category : #initialization }
GtPhpEchoStatement >> initialize [
	super initialize.
	expressions := OrderedCollection new.

]
