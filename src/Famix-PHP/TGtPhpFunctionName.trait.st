Trait {
	#name : #TGtPhpFunctionName,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #importing }
TGtPhpFunctionName >> importFrom: anElement [
	| nameXMLNode functionNameNode |
	super importFrom: anElement.
	
	nameXMLNode := anElement elements first.
	functionNameNode := (self newAstNodeNamed: nameXMLNode localName) 
		importFrom: nameXMLNode.
	functionNameNode parentNode: self.
	
	self 
		attributeAtXmlElementName: 'name' 
		put: functionNameNode
	
]

{ #category : #printing }
TGtPhpFunctionName >> shortDescriptionOn: aStream [ 
	self name shortDescriptionOn: aStream
]
