Class {
	#name : #GtPhpBlock,
	#superclass : #GtPhpStatement,
	#instVars : [
		'statements',
		'isCurly'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpBlock >> children [
	| result |
	result := super children.
	result addAll: statements.
	^ result
]

{ #category : #initialization }
GtPhpBlock >> initialize [
	super initialize.
	statements := OrderedCollection new.

]
