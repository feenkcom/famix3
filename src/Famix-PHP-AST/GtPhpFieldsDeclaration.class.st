Class {
	#name : #GtPhpFieldsDeclaration,
	#superclass : #GtPhpBodyDeclaration,
	#traits : 'TGtPhpFieldsDeclaration',
	#classTraits : 'TGtPhpFieldsDeclaration classTrait',
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
	result addAll: fields.
	fieldsType ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpFieldsDeclaration >> fields [
	^ fields
]

{ #category : #accessing }
GtPhpFieldsDeclaration >> fieldsType [
	^ fieldsType
]

{ #category : #initialization }
GtPhpFieldsDeclaration >> initialize [
	super initialize.
	fields := OrderedCollection new.

]
