Class {
	#name : #GtPhpTypeDeclaration,
	#superclass : #GtPhpStatement,
	#traits : 'TGtPhpTypeDeclaration',
	#classTraits : 'TGtPhpTypeDeclaration classTrait',
	#instVars : [
		'interfaces',
		'className',
		'block'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTypeDeclaration >> block [
	^ block
]

{ #category : #accessing }
GtPhpTypeDeclaration >> children [
	| result |
	result := super children.
	block ifNotNil: [ :x | result add: x ].
	result addAll: interfaces.
	className ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpTypeDeclaration >> className [
	^ className
]

{ #category : #initialization }
GtPhpTypeDeclaration >> initialize [
	super initialize.
	interfaces := OrderedCollection new.

]

{ #category : #accessing }
GtPhpTypeDeclaration >> interfaces [
	^ interfaces
]