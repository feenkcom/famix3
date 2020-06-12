Class {
	#name : #GtXmlInferredNodeReference,
	#superclass : #Object,
	#instVars : [
		'isMultivalued',
		'nodeType'
	],
	#category : #'Famix-PHP-Generator-Utils'
}

{ #category : #printing }
GtXmlInferredNodeReference >> gtDisplayOn: stream [
	stream nextPutAll: '->'.
	self nodeType gtDisplayOn: stream.
	self isMultivalued ifTrue: [ stream nextPutAll: '*' ]
]

{ #category : #initialize }
GtXmlInferredNodeReference >> initialize [
	isMultivalued := false
]

{ #category : #accessing }
GtXmlInferredNodeReference >> isMultivalued [
	^ isMultivalued
]

{ #category : #accessing }
GtXmlInferredNodeReference >> isMultivalued: anObject [
	isMultivalued := anObject
]

{ #category : #accessing }
GtXmlInferredNodeReference >> name [
	^ nodeType name
]

{ #category : #accessing }
GtXmlInferredNodeReference >> nodeType [
	^ nodeType
]

{ #category : #accessing }
GtXmlInferredNodeReference >> nodeType: anObject [
	nodeType := anObject
]
