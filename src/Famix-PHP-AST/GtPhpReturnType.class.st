Class {
	#name : #GtPhpReturnType,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'returnType'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpReturnType >> children [
	| result |
	result := super children.
	returnType ifNotNil: [ :x | result add: x ].
	^ result
]
