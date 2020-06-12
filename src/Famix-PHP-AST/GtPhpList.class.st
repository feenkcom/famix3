Class {
	#name : #GtPhpList,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'variables'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpList >> children [
	| result |
	result := super children.
	result addAll: variables.	^ result
]

{ #category : #initialization }
GtPhpList >> initialize [
	super initialize.
	variables := OrderedCollection new.

]
