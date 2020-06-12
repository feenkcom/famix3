Class {
	#name : #GtXmlInferredNodeType,
	#superclass : #Object,
	#instVars : [
		'name',
		'attributeNames',
		'childReferences'
	],
	#category : #'Famix-PHP-Generator-Utils'
}

{ #category : #accessing }
GtXmlInferredNodeType >> addAttributes: aCollection [
	attributeNames addAll: aCollection 
]

{ #category : #accessing }
GtXmlInferredNodeType >> addChildReferenceTo: aNodeType [
	childReferences 
		detect: [ :each | each nodeType = aNodeType ]
		ifNone: [ childReferences add: (GtXmlInferredNodeReference new nodeType: aNodeType) ]
]

{ #category : #accessing }
GtXmlInferredNodeType >> attributeNames [
	^ attributeNames
]

{ #category : #accessing }
GtXmlInferredNodeType >> attributeNames: anObject [
	attributeNames := anObject
]

{ #category : #accessing }
GtXmlInferredNodeType >> children [
	^ childReferences
]

{ #category : #accessing }
GtXmlInferredNodeType >> children: anObject [
	childReferences := anObject
]

{ #category : #printing }
GtXmlInferredNodeType >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #ui }
GtXmlInferredNodeType >> gtInspectorReferencesIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite list
		title: 'Children';
		display: [ childReferences ];
		format: #gtDisplayString
]

{ #category : #initialize }
GtXmlInferredNodeType >> initialize [
	childReferences := OrderedCollection new.
	attributeNames := Set new
]

{ #category : #accessing }
GtXmlInferredNodeType >> makeMultivaluedChildNamed: aString [
	(childReferences detect: [ :each | each name = aString ]) isMultivalued: true
]

{ #category : #accessing }
GtXmlInferredNodeType >> name [
	^ name
]

{ #category : #accessing }
GtXmlInferredNodeType >> name: anObject [
	name := anObject
]
