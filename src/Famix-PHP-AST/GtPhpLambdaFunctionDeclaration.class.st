Class {
	#name : #GtPhpLambdaFunctionDeclaration,
	#superclass : #GtPhpExpression,
	#instVars : [
		'lexicalVariables',
		'returnType',
		'formalParameters',
		'isStatic',
		'isReference',
		'functionBody'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> children [
	| result |
	result := super children.
	result addAll: lexicalVariables.
	returnType ifNotNil: [ :x | result add: x ].
	functionBody ifNotNil: [ :x | result add: x ].
	result addAll: formalParameters.
	^ result
]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> formalParameters [
	^ formalParameters
]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> functionBody [
	^ functionBody
]

{ #category : #initialization }
GtPhpLambdaFunctionDeclaration >> initialize [
	super initialize.
	lexicalVariables := OrderedCollection new.
	formalParameters := OrderedCollection new.

]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> isReference [
	^ isReference
]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> isStatic [
	^ isStatic
]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> lexicalVariables [
	^ lexicalVariables
]

{ #category : #accessing }
GtPhpLambdaFunctionDeclaration >> returnType [
	^ returnType
]
