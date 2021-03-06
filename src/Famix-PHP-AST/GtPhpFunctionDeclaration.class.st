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

{ #category : #accessing }
GtPhpFunctionDeclaration >> formalParameters [
	^ formalParameters
]

{ #category : #accessing }
GtPhpFunctionDeclaration >> functionBody [
	^ functionBody
]

{ #category : #accessing }
GtPhpFunctionDeclaration >> functionName [
	^ functionName
]

{ #category : #initialization }
GtPhpFunctionDeclaration >> initialize [
	super initialize.
	formalParameters := OrderedCollection new.

]

{ #category : #accessing }
GtPhpFunctionDeclaration >> isReference [
	^ isReference
]

{ #category : #accessing }
GtPhpFunctionDeclaration >> returnType [
	^ returnType
]
