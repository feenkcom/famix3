Class {
	#name : #GtPhpReturnStatement,
	#superclass : #GtPhpStatement,
	#traits : 'TGtPhpReturnStatement',
	#classTraits : 'TGtPhpReturnStatement classTrait',
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpReturnStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpReturnStatement >> expression [
	^ expression
]
