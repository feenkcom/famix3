Class {
	#name : #GtPhpSingleFieldDeclaration,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'value',
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> children [
	| result |
	result := super children.
	value ifNotNil: [ :x | result add: x ].
	name ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> name [
	^ name
]

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> value [
	^ value
]
