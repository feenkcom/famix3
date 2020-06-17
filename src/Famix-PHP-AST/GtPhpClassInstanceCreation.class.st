Class {
	#name : #GtPhpClassInstanceCreation,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'className',
		'anonymousClassDeclaration',
		'constructorParameters'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpClassInstanceCreation >> anonymousClassDeclaration [
	^ anonymousClassDeclaration
]

{ #category : #accessing }
GtPhpClassInstanceCreation >> children [
	| result |
	result := super children.
	className ifNotNil: [ :x | result add: x ].
	anonymousClassDeclaration ifNotNil: [ :x | result add: x ].
	result addAll: constructorParameters.
	^ result
]

{ #category : #accessing }
GtPhpClassInstanceCreation >> className [
	^ className
]

{ #category : #accessing }
GtPhpClassInstanceCreation >> constructorParameters [
	^ constructorParameters
]

{ #category : #accessing }
GtPhpClassInstanceCreation >> initialize [
	super initialize.
	constructorParameters := OrderedCollection new.

]
