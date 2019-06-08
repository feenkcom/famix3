Class {
	#name : #FAMIXCPPReferencesImportingVisitor,
	#superclass : #FAMIXCPPImportingVisitor,
	#category : #'Famix-CPP'
}

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> access: aNode from: method [
	| name index entity |
	name := aNode source.
	index := name lastIndexOf: $:.
	index > 0
		ifTrue: [ entity := self lookupClass: (name first: index - 1) from: aNode.
			name := name allButFirst: index + 1 ]
		ifFalse: [ entity := method ].
	(self findVariableNamed: name in: entity)
		ifNotNil: [ :var | 
			| access |
			aNode attributeNamed: #type put: var declaredType.
			access := FAMIXAccess new.
			self storeAST: aNode into: access.
			access sourceAnchor: (importer sourceAnchorFor: aNode).
			access accessor: method.
			access variable: var.
			self addEntity: access.
			self model add: access ]
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> addConstructorReferencesFor: aNode [
	(self typeFromSpecifiers: aNode specifiers in: aNode)
		ifNotNil: [ :type | 
			| constructors |
			constructors := type methods select: [ :each | each isConstructor ].
			self invoke: constructors from: aNode ]
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> findVariableNamed: aString in: anEntity [
	anEntity isNil
		ifTrue: [ ^ nil ].
	(anEntity isKindOf: FAMIXBehaviouralEntity)
		ifTrue: [ anEntity localVariables
				detect: [ :each | each name = aString ]
				ifFound: [ :each | ^ each ].
			anEntity parameters
				detect: [ :each | each name = aString ]
				ifFound: [ :each | ^ each ] ].
	(anEntity isKindOf: FAMIXMethod)
		ifTrue: [ ^ self findVariableNamed: aString in: anEntity parentType ].
	(anEntity isKindOf: FAMIXType)
		ifTrue: [ anEntity
				withSuperclassesDo: [ :cls | 
					cls attributes
						detect: [ :each | each name = aString ]
						ifFound: [ :each | ^ each ] ].
			^ self findVariableNamed: aString in: anEntity container ].
	(anEntity isKindOf: FAMIXScopingEntity)
		ifTrue: [ anEntity globalVariables
				detect: [ :each | each name = aString ]
				ifFound: [ :each | ^ each ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> includedFilename: aString [
	^ ('/includes/' , aString) asFileReference
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> invoke: possible from: aNode [
	| invocation |
	invocation := FAMIXInvocation new.
	self storeAST: aNode into: invocation.
	(self enclosingMethodOrFunctionFor: aNode)
		ifNotNil: [ :sender | invocation sender: sender ].
	invocation candidates: possible.
	invocation signature: (self formatSignature: aNode source).
	invocation sourceAnchor: (importer sourceAnchorFor: aNode).
	self addEntity: invocation.
	self model add: invocation.
	^ invocation
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> localFilename: aString from: aNode [
	| currentDirectory name |
	currentDirectory := aNode topParent filename asFileReference parent.
	name := (aString substrings: '/')
		inject: currentDirectory
		into: [ :sum :each | 
			each = '..'
				ifTrue: [ sum parent ]
				ifFalse: [ sum / each ] ].
	name exists
		ifTrue: [ ^ name ].
	^ self includedFilename: aString
]

{ #category : #private }
FAMIXCPPReferencesImportingVisitor >> processDirective: anInterval in: aNode [
	| source |
	source := aNode completeSource.
	'\#include\s*("|<)([^">]+)("|>)\s*' asRegex
		matchesIn: (source copyFrom: anInterval first to: anInterval last) asString
		subexpressionsDo: [ :string :items | 
			| included include |
			included := items first = '<'
				ifTrue: [ importer ensureFileNamed: (self includedFilename: items second) ]
				ifFalse: [ importer
						ensureFileNamed: (self localFilename: items second from: aNode) ].
			include := FAMIXInclude new.
			include source: importer currentFile.
			include target: included.
			include
				sourceAnchor:
					(importer
						sourceAnchorFor: aNode
						from: anInterval first
						to: anInterval last) yourself.
			self addEntity: include.
			self model add: include ]
]

{ #category : #visiting }
FAMIXCPPReferencesImportingVisitor >> visitCallExpression: aNode [
	| expression hasReceiver possible name methods functions invocation |
	expression := aNode expression.
	[ expression isKindOf: CPPMemberExpressionNode ]
		whileTrue: [ expression := expression id ].
	((expression isKindOf: CPPIdentifierExpressionNode)
		and: [ expression identifier isKindOf: CPPQualifiedIdentifierNode ])
		ifTrue: [ expression := expression identifier templateIdentifier ].
	name := expression source.
	hasReceiver := aNode expression isKindOf: CPPMemberExpressionNode.
	functions := hasReceiver
		ifTrue: [ #() ]
		ifFalse: [ importer functionsNamed: name ].
	methods := importer methodsNamed: name.
	possible := functions , methods
		reject: [ :each | 
			each minimumArgumentCount > aNode values size
				or: [ each isVariadic not
						and: [ aNode values size > each parameters size ] ] ].
	invocation := self invoke: possible from: aNode.
	(possible collect: [ :each | each declaredType ]) asSet
		ifNotEmpty: [ :types | 
			types size = 1
				ifTrue: [ aNode attributeNamed: #type put: types anyOne ] ].
	hasReceiver
		ifTrue: [ invocation receiverSourceCode: aNode expression expression source ].
	super visitCallExpression: aNode
]

{ #category : #visiting }
FAMIXCPPReferencesImportingVisitor >> visitIdentifierExpression: aNode [
	| parent |
	super visitIdentifierExpression: aNode.
	parent := aNode parent.
	((aNode identifier isKindOf: SmaCCErrorNode)
		or: [ (parent isKindOf: SmaCCErrorNode)
				or: [ (parent isKindOf: CPPDeclaratorNode)
						or: [ (parent isKindOf: CPPTemplateIdentifierNode)
								or: [ parent isKindOf: CPPCommaExpressionNode ] ] ] ])
		ifTrue: [ ^ self ].
	((parent isKindOf: CPPCallExpressionNode)
		and: [ parent expression == aNode ])
		ifTrue: [ ^ self ].
	((parent isKindOf: CPPMemberExpressionNode)
		and: [ parent id == aNode ])
		ifTrue: [ ^ self ].
	(self enclosingMethodOrFunctionFor: aNode)
		ifNotNil: [ :method | self access: aNode from: method ]
]

{ #category : #visiting }
FAMIXCPPReferencesImportingVisitor >> visitMemberExpression: aNode [
	super visitMemberExpression: aNode.
	(aNode expression attributeNamed: #type)
		ifNotNil: [ :type | 
			(self enclosingMethodOrFunctionFor: aNode)
				ifNotNil: [ :method | 
					(self findVariableNamed: aNode id source in: type)
						ifNotNil: [ :var | 
							| access |
							aNode attributeNamed: #type put: var declaredType.
							access := FAMIXAccess new.
							self storeAST: aNode into: access.
							access sourceAnchor: (importer sourceAnchorFor: aNode).
							access accessor: method.
							access variable: var.
							self addEntity: access.
							self model add: access ] ] ]
]

{ #category : #visiting }
FAMIXCPPReferencesImportingVisitor >> visitNewTypeIdentifier: aNode [
	self addConstructorReferencesFor: aNode.
	super visitNewTypeIdentifier: aNode
]

{ #category : #generated }
FAMIXCPPReferencesImportingVisitor >> visitSimpleDeclaration: aNode [
	(aNode declarators notEmpty
		and: [ aNode specifiers isEmpty
				and: [ aNode declarators first isKindOf: CPPInitDeclaratorNode ] ])
		ifTrue: [ | initializer |
			initializer := aNode declarators first initializer.
			(initializer isKindOf: CPPExpressionListInitializerNode)
				ifTrue: [ | name functions methods possible |
					name := aNode declarators first declarator source.
					functions := importer functionsNamed: name.
					methods := importer methodsNamed: name.
					possible := functions , methods.
					self invoke: possible from: aNode ] ].
	super visitSimpleDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPReferencesImportingVisitor >> visitTranslationUnit: aNode [
	(aNode attributeNamed: #preprocessorDirectives ifAbsent: [ #() ])
		do: [ :each | self processDirective: each in: aNode ].
	super visitTranslationUnit: aNode
]
