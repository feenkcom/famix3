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
GtPhpArrowFunctionDeclaration >> body [
	^ body
]

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> children [
	| result |
	result := super children.
	result addAll: formalParameters.
	returnType ifNotNil: [ :x | result add: x ].
	body ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> formalParameters [
	^ formalParameters
]

{ #category : #initialization }
GtPhpArrowFunctionDeclaration >> initialize [
	super initialize.
	formalParameters := OrderedCollection new.

]

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> isReference [
	^ isReference
]

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> isStatic [
	^ isStatic
]

{ #category : #accessing }
GtPhpArrowFunctionDeclaration >> returnType [
	^ returnType
]
