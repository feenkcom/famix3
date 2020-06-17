Class {
	#name : #GtPhpTraitUseStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'tsList',
		'traitNameList'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitUseStatement >> children [
	| result |
	result := super children.
	result addAll: traitNameList.
	result addAll: tsList.
	^ result
]

{ #category : #accessing }
GtPhpTraitUseStatement >> initialize [
	super initialize.
	traitNameList := OrderedCollection new.
	tsList := OrderedCollection new.

]

{ #category : #accessing }
GtPhpTraitUseStatement >> traitList [
	^ traitNameList
]

{ #category : #accessing }
GtPhpTraitUseStatement >> tsList [
	^ tsList
]
