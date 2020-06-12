Class {
	#name : #GtPhpFieldsDeclaration,
	#superclass : #GtPhpBodyDeclaration,
	#instVars : [
		'fields',
		'fieldsType'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFieldsDeclaration >> children [
	| result |
	result := super children.
	result addAll: fields.	fieldsType ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpFieldsDeclaration >> initialize [
	super initialize.
	fields := OrderedCollection new.

]
