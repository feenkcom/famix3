Class {
	#name : #GtPhpFunctionDeclaration,
	#superclass : #GtPhpStatement,
	#traits : 'TGtPhpFunctionDeclaration',
	#classTraits : 'TGtPhpFunctionDeclaration classTrait',
	#instVars : [
		'returnType',
		'isReference',
		'formalParameters',
		'functionBody',
		'functionName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFunctionDeclaration >> children [
	| result |
	result := super children.
	functionBody ifNotNil: [ :x | result add: x ].
	returnType ifNotNil: [ :x | result add: x ].
	functionName ifNotNil: [ :x | result add: x ].
	result addAll: formalParameters.
	^ result
]

{ #category : #initialization }
GtPhpFunctionDeclaration >> initialize [
	super initialize.
	formalParameters := OrderedCollection new.

]
