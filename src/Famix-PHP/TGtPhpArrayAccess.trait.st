Trait {
	#name : #TGtPhpArrayAccess,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #importing }
TGtPhpArrayAccess >> importFrom: anElement [
	| variableXMLNode identifierNode |
	super importFrom: anElement.
	
	variableXMLNode := anElement elements first.
	identifierNode := (self newAstNodeNamed: variableXMLNode localName) 
		importFrom: variableXMLNode.
	identifierNode parentNode: self.
	
	self 
		attributeAtXmlElementName: 'identifier' 
		put: identifierNode
	
]

{ #category : #printing }
TGtPhpArrayAccess >> shortDescriptionOn: aStream [
	self identifier shortDescriptionOn: aStream.
	aStream nextPutAll: '['.
	self index ifNotNil: [
		self index shortDescriptionOn: aStream ].
	aStream nextPutAll: ']'.
]
