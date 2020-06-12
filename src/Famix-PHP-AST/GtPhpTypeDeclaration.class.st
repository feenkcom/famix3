Class {
	#name : #GtPhpTypeDeclaration,
	#superclass : #GtPhpStatement,
	#instVars : [
		'interfaces',
		'className',
		'block'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTypeDeclaration >> children [
	| result |
	result := super children.
	block ifNotNil: [ :x | result add: x ].
	result addAll: interfaces.	className ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpTypeDeclaration >> initialize [
	super initialize.
	interfaces := OrderedCollection new.

]
