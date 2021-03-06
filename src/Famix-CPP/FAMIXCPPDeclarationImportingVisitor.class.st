Class {
	#name : #FAMIXCPPDeclarationImportingVisitor,
	#superclass : #FAMIXCPPImportingVisitor,
	#instVars : [
		'stack',
		'templateTypes',
		'cyclomaticComplexity'
	],
	#category : #'Famix-CPP'
}

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> acceptNode: aSmaCCParseNode [
	aSmaCCParseNode notNil
		ifTrue: [ cyclomaticComplexity := cyclomaticComplexity
				+ aSmaCCParseNode additionalCyclomaticComplexityEdges ].
	^ super acceptNode: aSmaCCParseNode
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> addModifiersFrom: declaration to: method [
	declaration specifiers
		do: [ :each | 
			(((each isKindOf: CPPDeclSpecifierNode)
				and: [ each source ~= 'typedef' ])
				or: [ (each isKindOf: CPPClassTypeNode) and: [ each source = 'final' ] ])
				ifTrue: [ method modifiers add: each source ] ]
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> addParametersTo: declarator to: function [
	| stream |
	stream := WriteStream on: String new.
	stream
		nextPutAll: function name;
		nextPut: $(.
	declarator declarations
		do: [ :each | 
			| name param |
			name := each declarator
				ifNil: [ each specifiers last source ]
				ifNotNil: [ :decl | 
					(decl isKindOf: CPPDeclaratorNode)
						ifTrue: [ decl id source ]
						ifFalse: [ decl source ] ].
			stream
				nextPutAll: (self normalizeTypeSource: each source forVariable: name).
			param := FAMIXParameter new name: name.
			self storeAST: each into: param.
			each attributeNamed: #entity put: param.
			param sourceAnchor: (importer sourceAnchorFor: each).
			each initializer notNil
				ifTrue: [ param beOptional ].
			self addEntity: param.
			self model add: param.
			function addParameter: param ]
		separatedBy: [ stream nextPutAll: ', ' ].
	stream nextPut: $).
	function signature: stream contents
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> addPropertiesTo: anEntity basedOn: declaration [
	| access accessToken |
	access := 'private'.
	accessToken := declaration parent accessTokens reversed
		detect: [ :each | each startPosition < declaration startPosition ]
		ifNone: [  ].
	accessToken notNil
		ifTrue: [ access := accessToken source ].
	access = 'private'
		ifTrue: [ anEntity isPrivate: true ].
	access = 'protected'
		ifTrue: [ anEntity isProtected: true ].
	access = 'public'
		ifTrue: [ anEntity isPublic: true ]
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> createTypeAliasFor: aNode [
	| type |
	type := importer
		createAliasTypeNamed: (self typedefNameFor: aNode)
		for: aNode.
	self currentType
		ifNotNil: [ :parentType | 
			parentType addType: type.
			type container: parentType ]
		ifNil: [ (self enclosingNamespaceEntityFor: aNode)
				ifNotNil: [ :entity | type container: entity ] ].
	aNode attributeNamed: #entity put: type.
	self addEntity: type
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> currentEnum [
	stack
		reverseDo: [ :each | 
			(each isKindOf: FAMIXEnum)
				ifTrue: [ ^ each ] ].
	^ self error: 'missing enum'
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> currentMethod [
	| method |
	method := stack isEmpty
		ifTrue: [ nil ]
		ifFalse: [ stack last ].
	^ (method isKindOf: FAMIXCPPMethod)
		ifTrue: [ method ]
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> currentType [
	stack
		reverseDo: [ :each | 
			(each isKindOf: FAMIXType)
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #'initialize-release' }
FAMIXCPPDeclarationImportingVisitor >> initialize [
	super initialize.
	stack := OrderedCollection new.
	cyclomaticComplexity := 0
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> methodNameFrom: aNode [
	| source |
	source := aNode source.
	(source includes: $()
		ifTrue: [ source := source first: (source indexOf: $() - 1 ].
	(source includes: $))
		ifTrue: [ source := source first: (source indexOf: $)) - 1 ].
	^ (source copyReplaceAll: '"' with: '') trim
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> normalizeTypeSource: parameterSource forVariable: aString [
	| source index nextIndex inStream outStream lastWasLetter afterEquals |
	(aString notEmpty and: [ aString first isLetter not ])
		ifTrue: [ source := parameterSource ]
		ifFalse: [ index := 0.
			[ (nextIndex := parameterSource
				indexOfSubCollection: aString
				startingAt: index + 1
				ifAbsent: [ 0 ]) > 0 ] whileTrue: [ index := nextIndex ].
			source := index > 0
				ifTrue: [ (parameterSource first: index - 1)
						,
							(parameterSource
								copyFrom: index + aString size
								to: parameterSource size) ]
				ifFalse: [ parameterSource ].
			source isEmpty
				ifTrue: [ source := parameterSource ] ].
	inStream := source readStream.
	outStream := WriteStream on: String new.
	lastWasLetter := false.
	afterEquals := false.
	[ inStream atEnd ]
		whileFalse: [ | char |
			char := inStream next.
			afterEquals
				ifTrue: [ (char = $, or: [ char = $) ])
						ifTrue: [ outStream nextPut: char.
							afterEquals := false ] ]
				ifFalse: [ char == $=
						ifTrue: [ afterEquals := true ]
						ifFalse: [ char isSeparator
								ifTrue: [ lastWasLetter
										ifTrue: [ inStream peek
												ifNotNil: [ :c | 
													c isLetter
														ifTrue: [ outStream nextPut: $  ] ] ] ]
								ifFalse: [ outStream nextPut: char ] ] ].
			lastWasLetter := char isLetter ].
	^ outStream contents
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> processDeclaration: declaration for: class in: aNode [
	(declaration isKindOf: CPPMemberDeclarationNode)
		ifFalse: [ ^ self ].
	(declaration isFriendDeclaration
		or: [ declaration isForwardDeclaration or: [ declaration isTypedef ] ])
		ifTrue: [ ^ self ].
	declaration isTypedef
		ifTrue: [ ^ self createTypeAliasFor: declaration ].
	declaration declarators isEmpty
		ifTrue: [ | attribute |
			declaration specifiers isEmpty
				ifTrue: [ ^ self ].
			(declaration isEnumSpecifier or: [ declaration isClassSpecifier ])
				ifTrue: [ (declaration specifiers last isKindOf: CPPClassTypeNode)
						ifFalse: [ ^ self ] ].
			attribute := FAMIXAttribute new
				name: declaration specifiers last source;
				sourceAnchor: (importer sourceAnchorFor: declaration).
			self addPropertiesTo: attribute basedOn: declaration.
			self addEntity: attribute.
			self model add: attribute.
			self storeAST: declaration into: attribute.
			declaration attributeNamed: #entity put: attribute.
			^ class addAttribute: attribute ].
	declaration declarators size = 1
		ifTrue: [ declaration declarators first declarator
				ifNotNil: [ :declarator | 
					(declarator leftParens notEmpty
						and: [ declarator leftParens last startPosition
								> declarator id startPosition ])
						ifTrue: [ | name method |
							name := importer removeNamespaceFrom: declarator id source.
							method := importer createMethodNamed: name in: nil for: nil.
							method
								declaration:
									(FAMIXCPPMethodDeclaration new
										sourceAnchor: (importer sourceAnchorFor: declaration)).
							self model add: method declaration.
							self addModifiersFrom: declaration to: method.
							self storeAST: declaration into: method.
							self storeAST: declaration into: method declaration.
							self addEntity: method.
							self addEntity: method declaration.
							self addPropertiesTo: method basedOn: declaration.
							self addParametersTo: declarator to: method.
							declarator parent virtualSpecifierTokens notEmpty
								ifTrue: [ method modifiers
										addAll: (declarator parent virtualSpecifierTokens collect: #value) asSet ].
							declaration attributeNamed: #entity put: method.
							^ class addMethod: method ]
						ifFalse: [ | attribute |
							attribute := FAMIXAttribute new.
							attribute name: declarator id source.
							attribute sourceAnchor: (importer sourceAnchorFor: declaration).
							self storeAST: declaration into: attribute.
							self addPropertiesTo: attribute basedOn: declaration.
							self addEntity: attribute.
							self model add: attribute.
							declaration attributeNamed: #entity put: attribute.
							^ class addAttribute: attribute ] ] ]
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> push: aFamixObject around: aBlock [
	stack add: aFamixObject.
	aBlock
		ensure: [ stack removeLast ]
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> signatureFor: declarator [
	| source |
	source := declarator ptrOperators isEmpty
		ifTrue: [ declarator source ]
		ifFalse: [ (declarator topParent completeSource
				copyFrom: declarator id startPosition
				to: declarator stopPosition) asString ].
	^ self formatSignature: source
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> signatureOf: declarator [
	| stream |
	stream := WriteStream on: String new.
	stream nextPut: $(.
	declarator declarations
		do: [ :each | 
			| name |
			name := each declarator
				ifNil: [ each specifiers last source ]
				ifNotNil: [ :decl | 
					(decl isKindOf: CPPDeclaratorNode)
						ifTrue: [ decl id source ]
						ifFalse: [ decl source ] ].
			stream
				nextPutAll: (self normalizeTypeSource: each source forVariable: name) ]
		separatedBy: [ stream nextPutAll: ', ' ].
	stream nextPut: $).
	^ stream contents
]

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> templateTypeNameFrom: aNode [
	(aNode isKindOf: CPPTypeParameterNode)
		ifTrue: [ ^ aNode name ifNotNil: [ :name | name source ] ].
	(aNode isKindOf: CPPParameterDeclarationNode)
		ifTrue: [ aNode declarator notNil
				ifTrue: [ ^ aNode declarator source ].
			aNode specifiers
				do: [ :each | 
					(each isKindOf: CPPElaboratedTypeSpecifierNode)
						ifTrue: [ ^ each name source ] ] ].
	^ nil
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> typedefNameFor: aNode [
	^ aNode typedefName
		ifNotNil: [ :name | 
			((importer namespaceNameFor: aNode)
				ifEmpty: [ '' ]
				ifNotEmpty: [ :s | s , '::' ]) , name ]
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitClassSpecifier: aNode [
	| name type |
	name := self nameFor: aNode.
	aNode isStructure
		ifTrue: [ templateTypes notNil
				ifTrue: [ type := importer createTemplateStructNamed: name for: aNode.
					templateTypes
						do: [ :each | 
							| paramType |
							paramType := FAMIXParameterType new.
							paramType name: each.
							self model add: paramType.
							self addEntity: paramType.
							type addType: paramType ] ]
				ifFalse: [ type := importer createStructNamed: name for: aNode ] ]
		ifFalse: [ aNode isUnion
				ifTrue: [ type := importer createUnionNamed: name for: aNode ]
				ifFalse: [ templateTypes notNil
						ifTrue: [ type := importer createTemplateClassNamed: name for: aNode.
							templateTypes
								do: [ :each | 
									| paramType |
									paramType := FAMIXParameterType new.
									paramType name: each.
									self model add: paramType.
									self addEntity: paramType.
									type addType: paramType ] ]
						ifFalse: [ type := importer createClassNamed: name for: aNode ] ] ].
	(((aNode nameSpecifier notNil
		and: [ aNode nameSpecifier type notNil ])
		ifTrue: [ self lookupClass: aNode nameSpecifier type source from: aNode ])
		ifNil: [ self currentType ])
		ifNotNil: [ :parentType | 
			parentType addType: type.
			type container: parentType ]
		ifNil: [ (self enclosingNamespaceEntityFor: aNode)
				ifNotNil: [ :entity | type container: entity ] ].
	self storeAST: aNode into: type.
	aNode attributeNamed: #entity put: type.
	self addEntity: type.
	self
		push: type
		around: [ aNode declarations
				do: [ :decl | self processDeclaration: decl for: type in: aNode ].
			super visitClassSpecifier: aNode ]
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitEnumDefinition: aNode [
	| enumValue |
	enumValue := importer
		createEnumValueNamed: aNode name source
		in: self currentEnum
		for: aNode.
	self storeAST: aNode into: enumValue.
	self addEntity: enumValue
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitEnumSpecifier: aNode [
	| name enum |
	name := self nameFor: aNode.
	enum := importer createEnumNamed: name for: aNode.
	self currentType ifNotNil: [ :parentType | parentType addType: enum ].
	self storeAST: aNode into: enum.
	aNode attributeNamed: #entity put: enum.
	self addEntity: enum.
	self push: enum around: [ super visitEnumSpecifier: aNode ]
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitFunctionDefinition: aNode [
	| name methodName index owner className method identifier oldComplexity potential |
	name := aNode declarator id source.
	index := name lastIndexOf: $:.
	index > 0
		ifTrue: [ methodName := name allButFirst: index.
			className := name first = $:
				ifTrue: [ aNode specifiers isEmpty
						ifTrue: [ aNode declarator id identifier nameSpecifier source ]
						ifFalse: [ aNode specifiers last source ] ]
				ifFalse: [ name first: index - 2 ].
			owner := self lookupClass: className from: aNode.
			owner notNil
				ifTrue: [ potential := owner methods
						select: [ :each | 
							each name = methodName
								and: [ each implementation isNil
										and: [ each parameters size = aNode declarator declarations size ] ] ].
					potential size = 1
						ifTrue: [ method := potential first ]
						ifFalse: [ potential notEmpty
								ifTrue: [ | signature |
									signature := methodName
										, (self signatureOf: aNode declarator).
									method := potential
										detect: [ :each | each signature endsWith: signature ]
										ifNone: [  ] ] ] ] ]
		ifFalse: [ methodName := name.
			owner := stack isEmpty
				ifTrue: [ nil ]
				ifFalse: [ stack last ] ].
	method isNil
		ifTrue: [ method := owner isNil
				ifTrue: [ importer createFunctionNamed: methodName for: aNode ]
				ifFalse: [ importer createMethodNamed: methodName in: owner for: aNode ].
			self addParametersTo: aNode declarator to: method.
			self storeAST: aNode into: method.
			self addEntity: method ].
	aNode declarator ellipsises notEmpty
		ifTrue: [ method beVariadic ].
	owner notNil
		ifTrue: [ method
				implementation:
					(FAMIXCPPMethodImplementation new
						sourceAnchor: (importer sourceAnchorFor: aNode)).
			self model add: method implementation.
			self storeAST: aNode into: method implementation.
			self addEntity: method implementation ].
	aNode specifiers isEmpty
		ifTrue: [ identifier := aNode declarator id identifier.
			(identifier isKindOf: CPPQualifiedIdentifierNode)
				ifTrue: [ identifier := identifier templateIdentifier ].
			((identifier isKindOf: CPPDestructorIdentifierNode)
				and: [ method isKindOf: FAMIXMethod ])
				ifTrue: [ method kind: #destructor ].
			((identifier isKindOf: CPPIdentifierNode)
				and: [ method isKindOf: FAMIXMethod ])
				ifTrue: [ method isConstructor: true ] ].
	self addModifiersFrom: aNode to: method.
	aNode virtualSpecifierTokens notEmpty
		ifTrue: [ method modifiers
				addAll: (aNode virtualSpecifierTokens collect: [ :each | each value ]) asSet ].
	aNode attributeNamed: #entity put: method.
	oldComplexity := cyclomaticComplexity.
	cyclomaticComplexity := 1.
	self push: method around: [ super visitFunctionDefinition: aNode ].
	method cyclomaticComplexity: cyclomaticComplexity.
	cyclomaticComplexity := oldComplexity
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitLambdaExpression: aLambdaExpressionNode [
	| name lambda oldComplexity |
	aLambdaExpressionNode rightParens notEmpty
		ifTrue: [ name := aLambdaExpressionNode completeSource
				ifNotNil: [ :value | 
					(value
						copyFrom: aLambdaExpressionNode startPosition
						to: aLambdaExpressionNode rightParens first stopPosition)
						asString ].
			lambda := importer
				createLambdaNamed: name
				in: self currentMethod
				for: aLambdaExpressionNode.
			self storeAST: aLambdaExpressionNode into: lambda.
			aLambdaExpressionNode attributeNamed: #entity put: lambda ].
	oldComplexity := cyclomaticComplexity.
	cyclomaticComplexity := 1.
	super visitLambdaExpression: aLambdaExpressionNode.
	lambda notNil
		ifTrue: [ lambda cyclomaticComplexity: cyclomaticComplexity ].
	cyclomaticComplexity := oldComplexity
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitMemberDeclaration: aNode [
	aNode isTypedef
		ifTrue: [ self createTypeAliasFor: aNode ].
	super visitMemberDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitOriginalNamespaceDefinition: aNode [
	| namespace |
	namespace := self enclosingNamespaceEntityFor: aNode.
	aNode names
		do: [ :each | 
			namespace := importer ensureNamespace: each source in: namespace.
			self addEntity: namespace ].
	aNode attributeNamed: #entity put: namespace.
	super visitOriginalNamespaceDefinition: aNode
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitSimpleDeclaration: aNode [
	aNode isTypedef
		ifTrue: [ self createTypeAliasFor: aNode ].
	aNode isExternalFunction
		ifTrue: [ | method |
			method := importer createFunctionNamed: aNode declarators first declarator id source for: aNode.
			self addParametersTo: aNode declarators first declarator to: method.
			self storeAST: aNode into: method.
			self addEntity: method.
			aNode attributeNamed: #entity put: method ].
	super visitSimpleDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitTemplateDeclaration: aNode [
	aNode parameters notEmpty
		ifTrue: [ templateTypes := aNode parameters
				collect: [ :each | self templateTypeNameFrom: each ] ].
	super visitTemplateDeclaration: aNode.
	templateTypes := nil
]
