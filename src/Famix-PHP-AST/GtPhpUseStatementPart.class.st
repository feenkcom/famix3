Class {
	#name : #GtPhpUseStatementPart,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'statementType',
		'name',
		'alias'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpUseStatementPart >> children [
	| result |
	result := super children.
	name ifNotNil: [ :x | result add: x ].
	alias ifNotNil: [ :x | result add: x ].
	^ result
]
