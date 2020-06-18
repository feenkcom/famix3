Class {
	#name : #GtPhpSingleFieldDeclaration,
	#superclass : #GtPhpASTNode,
	#traits : 'TGtPhpSingleFieldDeclaration',
	#classTraits : 'TGtPhpSingleFieldDeclaration classTrait',
	#instVars : [
		'initialValue',
		'variableName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> children [
	| result |
	result := super children.
	initialValue ifNotNil: [ :x | result add: x ].
	variableName ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> initialValue [
	^ initialValue
]

{ #category : #accessing }
GtPhpSingleFieldDeclaration >> variableName [
	^ variableName
]
