Class {
	#name : #GtPhpArrowFunctionDeclaration,
	#superclass : #GtPhpExpression,
	#instVars : [
		'isStatic',
		'isReference',
		'formalParameters',
		'returnType',
		'body'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> children [
	| result |
	result := super children.
	result addAll: formalParameters.	returnType ifNotNil: [ :x | result add: x ].
	body ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpArrowFunctionDeclaration >> initialize [
	super initialize.
	formalParameters := OrderedCollection new.

]
