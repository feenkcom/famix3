Class {
	#name : #GtPhpUseStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'statementType',
		'emptyPart',
		'namespace',
		'parts'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpUseStatement >> children [
	| result |
	result := super children.
	emptyPart ifNotNil: [ :x | result add: x ].
	namespace ifNotNil: [ :x | result add: x ].
	result addAll: parts.
	^ result
]

{ #category : #accessing }
GtPhpUseStatement >> emptyPart [
	^ emptyPart
]

{ #category : #initialization }
GtPhpUseStatement >> initialize [
	super initialize.
	parts := OrderedCollection new.

]

{ #category : #accessing }
GtPhpUseStatement >> namespace [
	^ namespace
]

{ #category : #accessing }
GtPhpUseStatement >> parts [
	^ parts
]

{ #category : #accessing }
GtPhpUseStatement >> statementType [
	^ statementType
]
