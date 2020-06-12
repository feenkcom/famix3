Class {
	#name : #GtPhpDeclareStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'directiveNames',
		'directiveValues',
		'body'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpDeclareStatement >> children [
	| result |
	result := super children.
	result addAll: directiveNames.	result addAll: directiveValues.	body ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpDeclareStatement >> initialize [
	super initialize.
	directiveNames := OrderedCollection new.
	directiveValues := OrderedCollection new.

]
