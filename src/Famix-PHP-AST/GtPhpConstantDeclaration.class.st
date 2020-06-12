Class {
	#name : #GtPhpConstantDeclaration,
	#superclass : #GtPhpBodyDeclaration,
	#instVars : [
		'names',
		'initializers'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpConstantDeclaration >> children [
	| result |
	result := super children.
	result addAll: names.	result addAll: initializers.	^ result
]

{ #category : #initialization }
GtPhpConstantDeclaration >> initialize [
	super initialize.
	names := OrderedCollection new.
	initializers := OrderedCollection new.

]
