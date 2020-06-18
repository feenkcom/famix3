Class {
	#name : #GtPhpIdentifier,
	#superclass : #GtPhpVariableBase,
	#traits : 'TGtPhpIdentifier',
	#classTraits : 'TGtPhpIdentifier classTrait',
	#instVars : [
		'nullable',
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpIdentifier >> name [
	^ name
]

{ #category : #accessing }
GtPhpIdentifier >> nullable [
	^ nullable
]
