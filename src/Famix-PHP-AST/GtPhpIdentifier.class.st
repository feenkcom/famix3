Class {
	#name : #GtPhpIdentifier,
	#superclass : #GtPhpVariableBase,
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
