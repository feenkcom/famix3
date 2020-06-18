Trait {
	#name : #TGtPhpFieldsDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #importing }
TGtPhpFieldsDeclaration >> importFrom: anElement [
	| singleFieldPairs |
	super importFrom: anElement.
	
	singleFieldPairs := anElement elements allButFirst.
	singleFieldPairs pairsDo: [ :variableXMLNode :initialValueXMLNode |
		| singleFieldXMLNode singleFieldNode lastNode |
		singleFieldXMLNode := XMLElement new.
		singleFieldXMLNode
			name: GtPhpSingleFieldDeclaration typeName;
			addNode: variableXMLNode copy;
			addNode: initialValueXMLNode copy.
		
		singleFieldNode := (self newAstNodeNamed: GtPhpSingleFieldDeclaration typeName) 
			importFrom: singleFieldXMLNode.
		singleFieldNode parentNode: self.
		
		lastNode := (singleFieldNode initialValue 
			ifNil: [ singleFieldNode variableName  ]
			ifNotNil: [ singleFieldNode initialValue ]).
		
		singleFieldNode start: singleFieldNode variableName start.
		singleFieldNode length: ((lastNode start asNumber + lastNode length asNumber) - singleFieldNode start asNumber) asString .
		
		self fields add: singleFieldNode ].
	
]

{ #category : #printing }
TGtPhpFieldsDeclaration >> shortDescriptionOn: aStream [
	self modifier ifNotNil: [ 
		aStream 
			nextPutAll: self modifier;
			nextPutAll: ' ' ].
	self fields 
		do: [ :aField | aField shortDescriptionOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', '] 
]
