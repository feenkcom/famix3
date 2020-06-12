Class {
	#name : #GtPhpClassDeclaration,
	#superclass : #GtPhpTypeDeclaration,
	#instVars : [
		'modifier',
		'superClassName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpClassDeclaration >> children [
	| result |
	result := super children.
	superClassName ifNotNil: [ :x | result add: x ].
	^ result
]
