Class {
	#name : #GtPhpClassName,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpClassName >> children [
	| result |
	result := super children.
	name ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpClassName >> name [
	^ name
]
