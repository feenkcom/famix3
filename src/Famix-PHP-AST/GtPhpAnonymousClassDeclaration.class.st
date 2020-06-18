Class {
	#name : #GtPhpAnonymousClassDeclaration,
	#superclass : #GtPhpExpression,
	#instVars : [
		'superClass',
		'body',
		'interfaces'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpAnonymousClassDeclaration >> body [
	^ body
]

{ #category : #accessing }
GtPhpAnonymousClassDeclaration >> children [
	| result |
	result := super children.
	superClass ifNotNil: [ :x | result add: x ].
	body ifNotNil: [ :x | result add: x ].
	result addAll: interfaces.
	^ result
]

{ #category : #initialization }
GtPhpAnonymousClassDeclaration >> initialize [
	super initialize.
	interfaces := OrderedCollection new.

]

{ #category : #accessing }
GtPhpAnonymousClassDeclaration >> interfaces [
	^ interfaces
]

{ #category : #accessing }
GtPhpAnonymousClassDeclaration >> superClass [
	^ superClass
]
