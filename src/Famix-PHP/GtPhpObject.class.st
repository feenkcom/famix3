"
I am the abstract superclass of the AST nodes (I simulate PHP Object).
I offer the infrastructure for  importing from a concrete XML file printed by PDT.
"
Class {
	#name : #GtPhpObject,
	#superclass : #MooseEntity,
	#instVars : [
		'propertyDictionary',
		'fileReference',
		'parentNode'
	],
	#category : #'Famix-PHP-Generator'
}

{ #category : #accessing }
GtPhpObject class >> classNamePrefix [
	^ 'GtPhp'
]

{ #category : #accessing }
GtPhpObject class >> typeName [ 
	^ self name removePrefix: self classNamePrefix
]

{ #category : #enumerating }
GtPhpObject >> allChildrenDo: aBlock [
	self childrenDo: [ :child | 
		child withAllChildrenDo: aBlock ]
]

{ #category : #enumerating }
GtPhpObject >> allChildrenSelect: aBlock [
	| result |
	result := OrderedCollection new.
	self allChildrenDo: [ :each | 
		(aBlock value: each) ifTrue: [ result add: each ] ].
	^ result
]

{ #category : #importing }
GtPhpObject >> astNodeClassNamed: aString [
	^ (self classNamePrefix, aString) asClass
]

{ #category : #private }
GtPhpObject >> attributeAt: aString [
	^ (self class allInstVarNames includes: aString asSymbol)
		ifTrue: [ self instVarNamed: aString asSymbol ]
		ifFalse: [ propertyDictionary at: aString ifAbsent: [ nil ] ]
]

{ #category : #private }
GtPhpObject >> attributeAt: aString put: aValue [
	(self class allInstVarNames includes: aString asSymbol)
		ifTrue: [ self instVarNamed: aString asSymbol put: aValue ]
		ifFalse: [ propertyDictionary at: aString put: aValue ]
]

{ #category : #private }
GtPhpObject >> attributeAtXmlElementName: aString [
	^ self attributeAt: (self attributeNameFromElementName: aString)
]

{ #category : #private }
GtPhpObject >> attributeAtXmlElementName: aString put: aValue [
	^ self attributeAt: aString uncapitalized put: aValue
]

{ #category : #private }
GtPhpObject >> attributeAtXmlElementNameWithSuperclassLookup: aString put: aValue [
	(self astNodeClassNamed: aString) 
		withDeep: #superclass
		do: [ :each |
			| astPropertyName |
			astPropertyName := (each name removePrefix: self classNamePrefix) uncapitalized.
			(self class allInstVarNames includes: astPropertyName asSymbol)
				ifTrue: [
					self attributeAt: astPropertyName put: aValue ] ]
]

{ #category : #private }
GtPhpObject >> attributeNameFromElementName: aString [
	^ aString uncapitalized
]

{ #category : #accessing }
GtPhpObject >> children [
	^ OrderedCollection new
]

{ #category : #enumerating }
GtPhpObject >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #enumerating }
GtPhpObject >> childrenSelect: aBlock [
	^ self children select: aBlock
]

{ #category : #accessing }
GtPhpObject >> classNamePrefix [
	^ self class classNamePrefix
]

{ #category : #accessing }
GtPhpObject >> fileReference [
	^ fileReference ifNil: [ 
		self parentNode ifNotNil: [ 
			self parentNode fileReference ] ]
]

{ #category : #accessing }
GtPhpObject >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #ui }
GtPhpObject >> gtCompleteSourceFor: aView [
	<gtView> 
	^ aView explicit
		title: 'Complete source';
		priority: 5;
		stencil: [ | e completeContent text |
			completeContent := self fileReference contents.
			text := BlRopedRawText string: completeContent.
			self withAllChildrenDo: [ :child |
				(child class = GtPhpIdentifier and: [
					child parentNode class = GtPhpFunctionDeclaration]) ifTrue: [ 
				(text 
					from: child start asNumber + 1 
					to: child start asNumber + child length asNumber)
				attributes:
					{(BlTextHighlightAttribute new
						beNotOverwritableByStyler;
						paint: (BrGlamorousColors neutralBackgroundColor))}.
				
					 ] ].
					 
			e := BrEditor new
				text: text;
				look: BrGlamorousCodeEditorLook new.
			
			e
				scrollToPosition: ( completeContent lineNumberCorrespondingToIndex: self start asNumber + 1).
			e ]
]

{ #category : #ui }
GtPhpObject >> gtInspectorChildrenIn: composite [
	<gtView>
	^ composite tree
		title: 'Children';
		items: [ { self } ];
		itemFormat: [ :each | each gtDisplayString ];
		children: #children
]

{ #category : #private }
GtPhpObject >> hasAttributeAtXmlElementName: aString [
	^ self class allInstVarNames 
		includes: (self attributeNameFromElementName: aString) asSymbol
	
	 
]

{ #category : #importing }
GtPhpObject >> importFrom: anElement [
	anElement attributes keysAndValuesDo: [ :key :value |
		self attributeAt: key put: value ].
	
	anElement elements do: [ :subElement |
		subElement hasAttributes
			ifTrue: [ 
				"the element describes a real obect in the AST"
				(self hasAttributeAtXmlElementName: subElement localName) 
					ifTrue: [ 
						self 
							attributeAtXmlElementName: subElement localName 
							put: ((self newAstNodeNamed: subElement localName) importFrom: subElement) ]
					ifFalse: [
						self 
							whenOnlyOneCollectionDo: [ :attributeName | 
								| attributeClass |
								attributeClass := (self classNamePrefix, subElement localName) asClass.
								(self attributeAt: attributeName) add: (attributeClass new importFrom: subElement) ] 
							otherwise: [ 
								self 
									attributeAtXmlElementNameWithSuperclassLookup: subElement localName 
									put: ((self newAstNodeNamed: subElement localName) importFrom: subElement) ] ] ]
			ifFalse: [
				"it describes only a child and the element name is the class name that should be instantiated" 
				((self attributeAtXmlElementName: subElement localName) isCollection)
					ifTrue: [ 
						subElement elements do: [ :subSubElement |
							(self attributeAtXmlElementName: subElement localName) add: ((self newAstNodeNamed: subSubElement localName) importFrom: subSubElement) ] ]
					ifFalse: [ 
						subElement elements notEmpty ifTrue: [
							self 
								attributeAtXmlElementName: subElement localName 
								put: ((self newAstNodeNamed: subElement elements first localName) importFrom: subElement elements first) ] ] ]
	].
	self children do: [ :each | each parentNode: self ]
]

{ #category : #importing }
GtPhpObject >> importFromFile: anXmlFile [
	| pattern parser originalContents parsedContents patchedContents |
	pattern := $= asPParser negate, '''''' asPParser.
	parser := pattern sea ==> [:t | ('' join: t first), '''', ('' join: t third)].
	originalContents := anXmlFile contents.
	parsedContents := parser star parse: originalContents.
	patchedContents := parsedContents ifNotEmpty: [ :col | '' join: col ] ifEmpty: [ originalContents ].
	^ self importFrom: (XMLDOMParser parse: patchedContents) elements first
]

{ #category : #initialization }
GtPhpObject >> initialize [
	super initialize.
	propertyDictionary := Dictionary new.
]

{ #category : #printing }
GtPhpObject >> mooseNameOn: stream [
	stream nextPutAll: self class typeName
]

{ #category : #importing }
GtPhpObject >> newAstNodeNamed: aString [
	^ (self astNodeClassNamed: aString) new
]

{ #category : #accessing }
GtPhpObject >> parentNode [
	^ parentNode
]

{ #category : #accessing }
GtPhpObject >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #accessing }
GtPhpObject >> propertyDictionary [
	^ propertyDictionary
]

{ #category : #accessing }
GtPhpObject >> propertyDictionary: anObject [
	propertyDictionary := anObject
]

{ #category : #importing }
GtPhpObject >> whenOnlyOneCollectionDo: aBlock otherwise: anotherBlock [
	| collections |
	collections := (self class allInstVarNames 
		reject: [:each | each = #propertyDictionary]) 
		select: [ :each | 
			(self instVarNamed: each) isString not and: [ 
				(self instVarNamed: each) isCollection ] ].
	^ collections size = 1
		ifTrue: [ aBlock value: collections first ]
		ifFalse: [ anotherBlock value ]
]

{ #category : #enumerating }
GtPhpObject >> withAllChildrenDo: aBlock [
	aBlock value: self.
	self allChildrenDo: aBlock
]
