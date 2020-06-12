Class {
	#name : #GtPhpListVariable,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'variables'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpListVariable >> children [
	| result |
	result := super children.
	result addAll: variables.	^ result
]

{ #category : #initialization }
GtPhpListVariable >> initialize [
	super initialize.
	variables := OrderedCollection new.

]
