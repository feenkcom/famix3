"
I take multiple XMLs printed by PDT and infer a schema out of them. 

[[[
inferrer := FkXmlNodeInferrer new.
'<folder-with-ast-files>' asFileReference files do: [ :each | inferrer inferFromFile: xmlFile ].

view := RTMondrian new.
view shape label text: [:each | each name ]; color: Color black.
view nodes: inferrer nodeTypes.
view edges connectToAll: [ :each | each children collect: #nodeType ].
view layout horizontalDominanceTree layered.
view
]]]
"
Class {
	#name : #GtXmlNodeInferrer,
	#superclass : #Object,
	#instVars : [
		'nodeTypes'
	],
	#category : #'Famix-PHP-Generator-Utils'
}

{ #category : #actions }
GtXmlNodeInferrer >> inferFromFile: anXmlFile [
	| xml pattern parser originalContents parsedContents patchedContents |
	pattern := $= asPParser negate, '''''' asPParser.
	parser := pattern sea ==> [:t | ('' join: t first), '''', ('' join: t third)].
	originalContents := anXmlFile contents.
	parsedContents := parser star parse: originalContents.
	patchedContents := parsedContents ifNotEmpty: [ :col | '' join: col ] ifEmpty: [ originalContents ].
	xml := XMLDOMParser parse: patchedContents.
	self inferFromXmlElement: xml elements first
]

{ #category : #actions }
GtXmlNodeInferrer >> inferFromXmlElement: anXmlElement [
	| nodeType |
	nodeType := nodeTypes 
		at: anXmlElement localName 
		ifAbsentPut: [ GtXmlInferredNodeType new name: anXmlElement localName ].
	nodeType addAttributes: (anXmlElement attributes keys).
	(anXmlElement elements groupedBy: [ :each | each localName ]) keysAndValuesDo: [ :key :value |
		value do: [ :each | 
			| childNodeType |
			childNodeType := self inferFromXmlElement: each.
			nodeType addChildReferenceTo: childNodeType ].
		value size > 1 ifTrue: [ nodeType makeMultivaluedChildNamed: key ] ].
	^ nodeType
]

{ #category : #initialization }
GtXmlNodeInferrer >> initialize [
	nodeTypes := Dictionary new
]

{ #category : #accessing }
GtXmlNodeInferrer >> nodeTypes [
	^ nodeTypes
]

{ #category : #accessing }
GtXmlNodeInferrer >> nodeTypes: anObject [
	nodeTypes := anObject
]
