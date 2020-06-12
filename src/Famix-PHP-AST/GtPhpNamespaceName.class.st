Class {
	#name : #GtPhpNamespaceName,
	#superclass : #GtPhpIdentifier,
	#instVars : [
		'segments',
		'global',
		'current'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpNamespaceName >> children [
	| result |
	result := super children.
	result addAll: segments.
	^ result
]

{ #category : #initialization }
GtPhpNamespaceName >> initialize [
	super initialize.
	segments := OrderedCollection new.

]
