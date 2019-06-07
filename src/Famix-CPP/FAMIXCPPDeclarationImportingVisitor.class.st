Class {
	#name : #FAMIXCPPDeclarationImportingVisitor,
	#superclass : #FAMIXCPPImportingVisitor,
	#instVars : [
		'stack',
		'templateTypes'
	],
	#category : #'Famix-CPP'
}

{ #category : #private }
FAMIXCPPDeclarationImportingVisitor >> addArgumentsTo: declarator to: function [
	declarator declarations
		do: [ :each | 
			| name param |
			name := each declarator
				ifNil: [ each specifiers last source ]
				ifNotNil: [ :decl | 
					(decl isKindOf: CPPDeclaratorNode)
						ifTrue: [ decl id source ]
						ifFalse: [ decl source ] ].
			param := FAMIXParameter new name: name.
			self addEntity: param.
			function addParameter: param ]
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
	stack := OrderedCollection new
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
FAMIXCPPDeclarationImportingVisitor >> processDeclaration: declaration for: class in: aNode [
	(declaration isKindOf: CPPMemberDeclarationNode)
		ifFalse: [ ^ self ].
	declaration declarators isEmpty
		ifTrue: [ | attribute |
			declaration specifiers isEmpty
				ifTrue: [ ^ self ].
			attribute := FAMIXAttribute new
				name: declaration specifiers last source;
				sourceAnchor: (importer sourceAnchorFor: declaration).
			self addPropertiesTo: attribute basedOn: declaration.
			self addEntity: attribute.
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
							name := declarator id source.
							method := importer createMethodNamed: name in: nil for: nil.
							method signature: (self signatureFor: declarator).
							method
								declaration:
									(FAMIXCPPMethodDeclaration new
										sourceAnchor: (importer sourceAnchorFor: declaration)).
							self storeAST: declaration into: method.
							self addEntity: method.
							self addEntity: method declaration.
							self addPropertiesTo: method basedOn: declaration.
							self addArgumentsTo: declarator to: method.
							declaration attributeNamed: #entity put: method.
							^ class addMethod: method ]
						ifFalse: [ | attribute |
							attribute := FAMIXAttribute new.
							attribute name: declarator id source.
							attribute sourceAnchor: (importer sourceAnchorFor: declaration).
							self storeAST: declaration into: attribute.
							self addPropertiesTo: attribute basedOn: declaration.
							self addEntity: attribute.
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
FAMIXCPPDeclarationImportingVisitor >> templateTypeNameFrom: aNode [
	(aNode isKindOf: CPPTypenameTypeParameterNode)
		ifTrue: [ ^ aNode name source ].
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
FAMIXCPPDeclarationImportingVisitor >> visitClassSpecifier: aNode [
	| name type |
	name := self nameFor: aNode.
	aNode structToken notNil
		ifTrue: [ type := importer createStructNamed: name for: aNode ]
		ifFalse: [ aNode unionToken notNil
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
	self currentType ifNotNil: [ :parentType | parentType addType: type ].
	(self enclosingNamespaceEntityFor: aNode)
		ifNotNil: [ :entity | type container: entity ].
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
	| name methodName index owner className method identifier |
	name := aNode declarator id source.
	index := name lastIndexOf: $:.
	index > 0
		ifTrue: [ methodName := name allButFirst: index.
			className := name first = $:
				ifTrue: [ aNode specifiers isEmpty
						ifTrue: [ aNode declarator id identifier nameSpecifier source ]
						ifFalse: [ aNode specifiers last source ] ]
				ifFalse: [ name first: (name indexOf: $:) - 1 ].
			owner := self lookupClass: className from: aNode.
			owner notNil
				ifTrue: [ method := owner methods
						detect: [ :each | 
							each name = methodName
								and: [ each implementation isNil
										and: [ each parameters size = aNode declarator declarations size ] ] ]
						ifNone: [  ] ] ]
		ifFalse: [ methodName := name.
			owner := stack isEmpty
				ifTrue: [ nil ]
				ifFalse: [ stack last ] ].
	method isNil
		ifTrue: [ method := owner isNil
				ifTrue: [ importer createFunctionNamed: methodName for: aNode ]
				ifFalse: [ importer createMethodNamed: methodName in: owner for: aNode ].
			self storeAST: aNode into: method.
			method signature: (self signatureFor: aNode declarator).
			self addEntity: method ].
	owner notNil
		ifTrue: [ method
				implementation:
					(FAMIXCPPMethodImplementation new
						sourceAnchor: (importer sourceAnchorFor: aNode)).
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
	aNode attributeNamed: #entity put: method.
	self push: method around: [ super visitFunctionDefinition: aNode ]
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitOriginalNamespaceDefinition: aNode [
	| namespace |
	namespace := importer
		ensureNamespace: aNode name source
		in: (self enclosingNamespaceEntityFor: aNode).
	aNode attributeNamed: #entity put: namespace.
	self addEntity: namespace.
	super visitOriginalNamespaceDefinition: aNode
]

{ #category : #visiting }
FAMIXCPPDeclarationImportingVisitor >> visitSimpleDeclaration: aNode [
	aNode isSimpleTypedef
		ifTrue: [ | type |
			type := importer
				createAliasTypeNamed: aNode specifiers last source
				for: aNode.
			aNode attributeNamed: #entity put: type.
			self addEntity: type ].
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
