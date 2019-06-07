Class {
	#name : #FAMIXCPPImportingVisitor,
	#superclass : #CPPProgramNodeVisitor,
	#instVars : [
		'importer',
		'importedNamespaces',
		'importedNames'
	],
	#category : #'Famix-CPP'
}

{ #category : #private }
FAMIXCPPImportingVisitor >> addEntity: anEntity [
	importer currentFile addEntity: anEntity
]

{ #category : #private }
FAMIXCPPImportingVisitor >> enclosingClassEntityFor: aNode [
	| current |
	current := aNode.
	[ current := current parentOfType: CPPClassSpecifierNode.
	current notNil ]
		whileTrue: [ (current attributeNamed: #entity) ifNotNil: [ :entry | ^ entry ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPImportingVisitor >> enclosingEntityFor: aNode [
	| current |
	current := aNode.
	[ current notNil ]
		whileTrue: [ (current attributeNamed: #entity) ifNotNil: [ :entry | ^ entry ].
			current := current parent ].
	^ nil
]

{ #category : #private }
FAMIXCPPImportingVisitor >> enclosingMethodOrFunctionFor: aNode [
	| current |
	current := aNode.
	[ current := current nodeOfType: CPPFunctionDefinitionNode.
	current notNil ]
		whileTrue: [ (current attributeNamed: #entity) ifNotNil: [ :entry | ^ entry ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPImportingVisitor >> enclosingNamespaceEntityFor: aNode [
	| current |
	current := aNode.
	[ current := current parentOfType: CPPOriginalNamespaceDefinitionNode.
	current notNil ]
		whileTrue: [ (current attributeNamed: #entity) ifNotNil: [ :entry | ^ entry ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPImportingVisitor >> formatSignature: aString [
	| readStream lastIsSpace |
	readStream := (aString
		trimLeft: [ :char | char isSeparator ]
		right: [ :char | char = $; or: [ char isSeparator ] ]) readStream.
	lastIsSpace := true.
	^ String
		streamContents: [ :stream | 
			[ readStream atEnd ]
				whileFalse: [ | char |
					char := readStream next.
					(char isSeparator and: [ lastIsSpace ])
						ifFalse: [ stream nextPut: char ].
					lastIsSpace := char isSeparator ] ]
]

{ #category : #accessing }
FAMIXCPPImportingVisitor >> importer [
	^ importer
]

{ #category : #accessing }
FAMIXCPPImportingVisitor >> importer: cppImporter [
	importer := cppImporter
]

{ #category : #initialization }
FAMIXCPPImportingVisitor >> initialize [
	super initialize.
	importedNamespaces := OrderedCollection new.
	importedNames := Dictionary new
]

{ #category : #private }
FAMIXCPPImportingVisitor >> lookupClass: aString from: aNode [
	^ importer
		lookupType: aString
		from: aNode
		importedNamespaces: importedNamespaces
		importedNames: importedNames
]

{ #category : #private }
FAMIXCPPImportingVisitor >> model [
	^ importer model
]

{ #category : #private }
FAMIXCPPImportingVisitor >> nameFor: aNode [
	| nsSpecifier |
	nsSpecifier := aNode nameSpecifier
		ifNotNil: [ :ns | ns source ]
		ifNil: [ '' ].
	^ ((importer namespaceNameFor: aNode)
		ifEmpty: [ '' ]
		ifNotEmpty: [ :s | s , '::' ]) , nsSpecifier
		,
			(aNode name
				ifNil: [ (self typeDefNameFor: aNode)
						ifNil: [ 'anonymous ' , aNode startPosition printString ] ]
				ifNotNil: [ :n | n source ])
]

{ #category : #private }
FAMIXCPPImportingVisitor >> primitiveTypeNamed: aString in: aNode [
	| type |
	aString isEmpty
		ifTrue: [ ^ nil ].
	type := importer
		lookupType: aString
		from: aNode
		importedNamespaces: importedNamespaces
		importedNames: importedNames.
	type isNil
		ifTrue: [ type := importer ensurePrimitiveTypeNamed: aString.
			type isStub: true ].
	^ type
]

{ #category : #private }
FAMIXCPPImportingVisitor >> storeAST: aNode into: anEntity [
	importer storeAST: aNode into: anEntity
]

{ #category : #private }
FAMIXCPPImportingVisitor >> typeArgumentFor: aNode [
	((aNode isKindOf: CPPTypeIdentifierNode)
		and: [ aNode declarator isKindOf: CPPPtrAbstractDeclaratorNode ])
		ifTrue: [ ^ self typeFromSpecifiers: aNode specifiers in: aNode ].
	(aNode isKindOf: CPPCallExpressionNode)
		ifTrue: [ ^ self typeNamed: aNode expression source in: aNode ].
	(aNode isKindOf: CPPLiteralNode)
		ifTrue: [ ^ nil ].
	^ self typeNamed: aNode source in: aNode
]

{ #category : #private }
FAMIXCPPImportingVisitor >> typeDefNameFor: aNode [
	((aNode parent isKindOf: CPPSimpleDeclarationNode)
		or: [ aNode parent isKindOf: CPPMemberDeclarationNode ])
		ifTrue: [ | specifiers |
			specifiers := aNode parent specifiers.
			(specifiers size >= 3
				and: [ specifiers first source = 'typedef'
						and: [ specifiers second == aNode ] ])
				ifTrue: [ ^ specifiers third source ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPImportingVisitor >> typeFromSpecifiers: specifiers in: aNode [
	| type typeArgs |
	type := self
		typeNamed:
			(String
				streamContents: [ :stream | 
					specifiers
						do: [ :each | 
							(each isKindOf: CPPClassSpecifierNode)
								ifTrue: [ (each attributeNamed: #entity) ifNotNil: [ :t | ^ t ] ].
							(each isKindOf: CPPPrimitiveTypeNode)
								ifTrue: [ ^ self primitiveTypeNamed: each name source in: nil ].
							(each isKindOf: CPPClassTypeNode)
								ifTrue: [ | source |
									typeArgs := (each name isKindOf: CPPTemplateIdentifierNode)
										ifTrue: [ each name arguments ].
									source := each source.
									(stream position = 0 or: [ source beginsWith: '::' ])
										ifTrue: [ stream nextPutAll: source ] ] ] ])
		in: aNode.
	(typeArgs notNil and: [ type isKindOf: FAMIXParameterizableClass ])
		ifTrue: [ type := importer
				ensureParameterizedTypeFor: type
				with:
					((typeArgs collect: [ :each | self typeArgumentFor: each ])
						reject: [ :each | each isNil ]) ].
	^ type
]

{ #category : #private }
FAMIXCPPImportingVisitor >> typeNamed: aString in: aNode [
	| type index name |
	aString isEmpty
		ifTrue: [ ^ nil ].
	index := aString indexOf: $<.
	name := index > 0
		ifTrue: [ aString first: index - 1 ]
		ifFalse: [ aString ].
	type := importer
		lookupType: name
		from: aNode
		importedNamespaces: importedNamespaces
		importedNames: importedNames.
	type isNil
		ifTrue: [ type := index > 0
				ifTrue: [ importer ensureTemplateClassNamed: name ]
				ifFalse: [ importer ensureClassNamed: name ].
			type isStub: true ].
	^ type
]

{ #category : #generated }
FAMIXCPPImportingVisitor >> visitUsingDeclaration: aNode [
	importedNames
		at: aNode identifier source
		put: aNode nameSpecifier source , aNode identifier source.
	super visitUsingDeclaration: aNode
]

{ #category : #generated }
FAMIXCPPImportingVisitor >> visitUsingDirective: aNode [
	importedNamespaces
		add:
			(aNode nameSpecifier ifNil: [ '' ] ifNotNil: [ :ns | ns source ])
				, aNode name source.
	super visitUsingDirective: aNode
]
