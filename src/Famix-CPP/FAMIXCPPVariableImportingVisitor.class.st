Class {
	#name : #FAMIXCPPVariableImportingVisitor,
	#superclass : #FAMIXCPPImportingVisitor,
	#category : #'Famix-CPP'
}

{ #category : #private }
FAMIXCPPVariableImportingVisitor >> createGlobal: declarator from: specifiers in: aNode [
	| decl name |
	decl := declarator.
	(decl isKindOf: CPPInitDeclaratorNode)
		ifTrue: [ decl := decl declarator ].
	(decl isKindOf: CPPDeclaratorNode)
		ifFalse: [ ^ self ].
	name := decl id source.
	self createGlobalNamed: name from: specifiers in: aNode
]

{ #category : #private }
FAMIXCPPVariableImportingVisitor >> createGlobalNamed: name from: specifiers in: aNode [
	| variable |
	variable := FAMIXGlobalVariable new.
	self storeAST: aNode into: variable.
	variable name: name.
	variable sourceAnchor: (importer sourceAnchorFor: aNode).
	self addEntity: variable.
	self model add: variable.
	(self typeFromSpecifiers: specifiers in: aNode)
		ifNotNil: [ :type | variable declaredType: type ]
]

{ #category : #private }
FAMIXCPPVariableImportingVisitor >> createTemp: declarator from: specifiers in: aNode [
	| decl |
	decl := declarator.
	(decl isKindOf: CPPInitDeclaratorNode)
		ifTrue: [ decl := decl declarator ].
	(decl isKindOf: CPPDeclaratorNode)
		ifFalse: [ ^ self ].
	(self enclosingMethodOrFunctionFor: decl)
		ifNotNil: [ :method | 
			| variable |
			variable := FAMIXLocalVariable new.
			self storeAST: aNode into: variable.
			variable name: declarator id source.
			variable sourceAnchor: (importer sourceAnchorFor: aNode).
			method addLocalVariable: variable.
			self addEntity: variable.
			self model add: variable.
			(self typeFromSpecifiers: specifiers in: decl)
				ifNotNil: [ :type | variable declaredType: type ] ]
]

{ #category : #private }
FAMIXCPPVariableImportingVisitor >> createTempNamed: varName as: typeName in: aNode [
	(self enclosingMethodOrFunctionFor: aNode)
		ifNotNil: [ :method | 
			| variable |
			variable := FAMIXLocalVariable new.
			self storeAST: aNode into: variable.
			variable name: varName.
			variable sourceAnchor: (importer sourceAnchorFor: aNode).
			method addLocalVariable: variable.
			self addEntity: variable.
			self model add: variable.
			(self typeNamed: typeName in: aNode)
				ifNotNil: [ :type | variable declaredType: type ] ]
]

{ #category : #private }
FAMIXCPPVariableImportingVisitor >> typeDefTypeFor: specifier in: aNode [
	(specifier attributeNamed: #entity)
		ifNotNil: [ :entity | 
			entity isType
				ifTrue: [ ^ entity ] ].
	^ self typeNamed: aNode specifiers second source in: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitAssignmentExpression: aNode [
	(aNode lhs isKindOf: CPPBinaryExpressionNode)
		ifTrue:
			[ "Hack to handle ambiguous parse of 'a *b = c' as an assignment statement instead of a variable declaration"
			| source |
			source := aNode lhs operator source.
			(#('*' '&') includes: source)
				ifTrue: [ self
						createTempNamed: aNode lhs right source
						as: aNode lhs left source
						in: aNode ].
			(source = '>'
				and: [ (aNode source occurrencesOf: $<) = (aNode source occurrencesOf: $>) ])
				ifTrue: [ self
						createTempNamed: aNode lhs right source
						as: aNode lhs left source , '>'
						in: aNode ] ].
	super visitAssignmentExpression: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitBaseSpecifier: aNode [
	| name sub spr inheritance |
	name := importer removeGenericsFrom: aNode type source.
	sub := self enclosingClassEntityFor: aNode.
	spr := importer
		lookupType: name
		from: aNode
		importedNamespaces: importedNamespaces
		importedNames: importedNames.
	spr isNil
		ifTrue: [ spr := importer ensureClassNamed: name.
			spr isStub: true ].
	inheritance := FAMIXInheritance new.
	self storeAST: aNode into: inheritance.
	inheritance superclass: spr.
	inheritance subclass: sub.
	inheritance sourceAnchor: (importer sourceAnchorFor: aNode).
	self addEntity: inheritance.
	self model add: inheritance.
	super visitBaseSpecifier: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitCommaExpression: aNode [
	((aNode right isKindOf: CPPAssignmentExpressionNode)
		and: [ (aNode right lhs isKindOf: CPPBinaryExpressionNode)
				and: [ (aNode left isKindOf: CPPBinaryExpressionNode)
						and: [ aNode left operator source = '<' ] ] ])
		ifTrue:
			[ "Hack to handle ambiguous parse of 'a<b,c<d>>e=f' as a comma expression instead of a variable declaration"
			self
				createTempNamed: aNode right lhs right source
				as:
					(aNode topParent completeSource
						copyFrom: aNode startPosition
						to: aNode right lhs operator stopPosition) asString
				in: aNode ].
	super visitCommaExpression: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitCondition: aNode [
	self createTemp: aNode declarator from: aNode specifiers in: aNode.
	super visitCondition: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitEnumSpecifier: aNode [
	(self typeFromSpecifiers: aNode specifiers in: aNode)
		ifNotNil: [ :type | 
			(aNode attributeNamed: #entity)
				ifNotNil: [ :entity | entity values do: [ :each | each declaredType: type ] ] ].
	super visitEnumSpecifier: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitExceptionDeclaration: aNode [
	self createTemp: aNode declarator from: aNode specifiers in: aNode.
	super visitExceptionDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitExpressionStatement: aNode [
	(aNode expression isKindOf: CPPBinaryExpressionNode)
		ifTrue:
			[ "Hack to handle ambiguous parse of 'a<b>c' as an binary expression instead of a variable declaration"
			| source |
			source := aNode expression operator source.
			(#('*' '&') includes: source)
				ifTrue: [ self
						createTempNamed: aNode expression right source
						as: aNode expression left source
						in: aNode ].
			(source = '>'
				and: [ (aNode source occurrencesOf: $<) = (aNode source occurrencesOf: $>) ])
				ifTrue: [ self
						createTempNamed: aNode expression right source
						as: aNode expression left source , '>'
						in: aNode ] ].
	super visitExpressionStatement: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitForRangeDeclaration: aNode [
	self createTemp: aNode declarator from: aNode specifiers in: aNode.
	super visitForRangeDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitFunctionDefinition: aNode [
	(self enclosingMethodOrFunctionFor: aNode)
		ifNotNil: [ :entity | 
			(self typeFromSpecifiers: aNode specifiers in: aNode)
				ifNotNil: [ :type | entity declaredType: type ]
				ifNil: [ | identifier |
					identifier := aNode declarator id identifier.
					(identifier isKindOf: CPPConversionFunctionIdentifierNode)
						ifTrue: [ (self typeFromSpecifiers: identifier specifiers in: aNode)
								ifNotNil: [ :type | entity declaredType: type ] ] ] ].
	super visitFunctionDefinition: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitLambdaExpression: aNode [
	| lambda |
	lambda := importer
		ensureFunctionNamed: 'anonymous ' , aNode startPosition printString.
	self storeAST: aNode into: lambda.
	aNode attributeNamed: #entity put: lambda.
	self addEntity: lambda.
	super visitLambdaExpression: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitMemberDeclaration: aNode [
	(aNode attributeNamed: #entity)
		ifNotNil: [ :entity | 
			entity isType
				ifFalse: [ (self typeFromSpecifiers: aNode specifiers in: aNode)
						ifNotNil: [ :type | entity declaredType: type ] ] ].
	aNode isTypedef
		ifTrue: [ (aNode attributeNamed: #entity)
				ifNotNil: [ :alias | 
					(self typeDefTypeFor: aNode specifiers second in: aNode)
						ifNotNil: [ :type | alias aliasedType: type ] ] ].
	super visitMemberDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitParameterDeclaration: aNode [
	(aNode attributeNamed: #entity)
		ifNotNil: [ :entity | 
			(self typeFromSpecifiers: aNode specifiers in: aNode)
				ifNotNil: [ :type | entity declaredType: type ] ].
	super visitParameterDeclaration: aNode
]

{ #category : #visiting }
FAMIXCPPVariableImportingVisitor >> visitSimpleDeclaration: aNode [
	aNode specifiers notEmpty
		ifTrue: [ | isMethod |
			isMethod := (aNode parentOfType: CPPFunctionDefinitionNode) notNil.
			aNode declarators notEmpty
				ifTrue: [ aNode declarators
						do: [ :each | 
							isMethod
								ifTrue: [ self createTemp: each from: aNode specifiers in: aNode ]
								ifFalse: [ self createGlobal: each from: aNode specifiers in: aNode ] ] ]
				ifFalse: [ (aNode specifiers size = 2
						and: [ aNode specifiers
								allSatisfy: [ :each | each isKindOf: CPPClassTypeNode ] ])
						ifTrue: [ isMethod
								ifTrue: [ self
										createTempNamed: aNode specifiers last source
										as: aNode specifiers first source
										in: aNode ]
								ifFalse: [ self
										createGlobalNamed: aNode specifiers last source
										from: (aNode specifiers allButLast: 1)
										in: aNode ] ] ] ].
	aNode isTypedef
		ifTrue: [ (aNode attributeNamed: #entity)
				ifNotNil: [ :alias | 
					(self typeDefTypeFor: aNode specifiers second in: aNode)
						ifNotNil: [ :type | alias aliasedType: type ] ] ].
	super visitSimpleDeclaration: aNode
]
