Class {
	#name : #GtPhpIgnoreError,
	#superclass : #GtPhpExpression,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpIgnoreError >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]
