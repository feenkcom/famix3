Class {
	#name : #GtPhpMethodDeclaration,
	#superclass : #GtPhpBodyDeclaration,
	#instVars : [
		'comment',
		'functionDeclaration'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpMethodDeclaration >> children [
	| result |
	result := super children.
	functionDeclaration ifNotNil: [ :x | result add: x ].
	comment ifNotNil: [ :x | result add: x ].
	^ result
]
