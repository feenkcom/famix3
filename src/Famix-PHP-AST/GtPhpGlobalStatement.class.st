Class {
	#name : #GtPhpGlobalStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'variables'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpGlobalStatement >> children [
	| result |
	result := super children.
	result addAll: variables.
	^ result
]

{ #category : #initialization }
GtPhpGlobalStatement >> initialize [
	super initialize.
	variables := OrderedCollection new.

]
