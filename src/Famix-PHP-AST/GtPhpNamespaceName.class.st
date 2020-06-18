Class {
	#name : #GtPhpNamespaceName,
	#superclass : #GtPhpIdentifier,
	#traits : 'TGtPhpNamespaceName',
	#classTraits : 'TGtPhpNamespaceName classTrait',
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

{ #category : #accessing }
GtPhpNamespaceName >> current [
	^ current
]

{ #category : #accessing }
GtPhpNamespaceName >> global [
	^ global
]

{ #category : #initialization }
GtPhpNamespaceName >> initialize [
	super initialize.
	segments := OrderedCollection new.

]

{ #category : #accessing }
GtPhpNamespaceName >> segments [
	^ segments
]
