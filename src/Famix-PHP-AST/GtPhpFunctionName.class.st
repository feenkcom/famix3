Class {
	#name : #GtPhpFunctionName,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFunctionName >> children [
	| result |
	result := super children.
	name ifNotNil: [ :x | result add: x ].
	^ result
]
