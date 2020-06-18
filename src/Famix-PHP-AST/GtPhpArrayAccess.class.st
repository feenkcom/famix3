Class {
	#name : #GtPhpArrayAccess,
	#superclass : #GtPhpVariable,
	#traits : 'TGtPhpArrayAccess',
	#classTraits : 'TGtPhpArrayAccess classTrait',
	#instVars : [
		'index',
		'type'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpArrayAccess >> children [
	| result |
	result := super children.
	index ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #importing }
GtPhpArrayAccess >> importFrom: anElement [
	| variableNode |
	super importFrom: anElement.
	
	variableNode := anElement elements first.
	self 
		attributeAtXmlElementName: 'identifier' 
		put: ((self newAstNodeNamed: variableNode localName) importFrom: variableNode)
	
]

{ #category : #accessing }
GtPhpArrayAccess >> index [
	^ index
]

{ #category : #accessing }
GtPhpArrayAccess >> type [
	^ type
]
