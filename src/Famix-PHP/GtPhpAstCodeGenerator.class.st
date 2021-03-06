"
I take a FAMIX model of pdt.core and generate the Pharo AST code.

pdt.core is found here:
https://github.com/eclipse/pdt
https://github.com/eclipse/pdt/tree/master/plugins/org.eclipse.php.core

!Example
[[[
	| model |
	model := MooseModel new 
		importFromMSEStream: (StandardFileStream readOnlyFileNamed: '../pdt/plugins/org.eclipse.php.core/org.eclipse.php.core.mse' asFileReference fullName).
	GtPhpAstCodeGenerator new generateFromPDTCoreModel: model
]]]

[[[
	{GtPhpListVariable -> #GtPhpList . 
	GtPhpInstanceOfExpression -> #GtPhpInstanceofExpression} do: [ :tuple |
		(RBRenameClassRefactoring
				rename: tuple key
				to: tuple value) execute ].
]]]
"
Class {
	#name : #GtPhpAstCodeGenerator,
	#superclass : #Object,
	#instVars : [
		'variablesRenames'
	],
	#category : #'Famix-PHP-Generator'
}

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> addTraitUsageIfNecessaryToASTNodeClass: aFAMIXClass in: anRBNamespace [
	| className traitName trait |
	className := self pharoClassName: aFAMIXClass name.
	traitName := 'T', className.
	
	trait := Smalltalk globals
		at: traitName asSymbol
		ifAbsent: [ ^ self ].
	trait isTrait
		ifFalse: [ ^ self  ]. 
	
	(RBAddTraitUsageToClassByNameRefactoring 
		traitName: traitName 
		inClassNamed: className)
			model: anRBNamespace;
			primitiveExecute.
]

{ #category : #private }
GtPhpAstCodeGenerator >> applyCustomRefactoringsIn: namespace [
	{
		#GtPhpListVariable -> #GtPhpList ". 
		#GtPhpInstanceOfExpression -> #GtPhpInstanceofExpression"
	} do: [ :tuple |
		(RBRenameClassRefactoring new
			model: namespace;
			className: tuple key newName: tuple value;
			yourself) primitiveExecute ].

	self variablesRenames do: [ :tuple | 
		(RBRenameInstanceVariableRefactoring
			model: namespace
			rename: tuple second key
			to: tuple second value
			in: tuple first) primitiveExecute ].
	
	{{#GtPhpASTNode . #start}.
	{#GtPhpASTNode . #length}}
		do: [ :tuple | 
			(RBCreateAccessorsForVariableRefactoring
				model: namespace
				variable: tuple second
				class: tuple first
				classVariable: false) primitiveExecute ]
]

{ #category : #accesssing }
GtPhpAstCodeGenerator >> attributeNamesForASTNodeClass: aFAMIXClass [
	^ aFAMIXClass attributes
			reject: #hasClassScope
			thenCollect: [ :attribute | self instVarNameForAttribute: attribute ]
]

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> generateAccessorMethodsForASTNodeClass: aFAMIXClass in: anRBNamespace [
	(self attributeNamesForASTNodeClass: aFAMIXClass) do: [ :anAttributeName | 
		| className methodSource actualAttributeName |
		actualAttributeName := anAttributeName.
		className := (self pharoClassName: aFAMIXClass name) asSymbol.
		self variablesRenames 
			detect: [ :tuple | (tuple first = className) and: [ 
				tuple second key = anAttributeName ] ]
			ifFound: [ :tuple | 
				actualAttributeName := tuple second value ].
		
		methodSource := String streamContents: [ :s |
			s nextPutAll: actualAttributeName; cr.
			s 
				tab; 
				nextPutAll: '^ ';
				nextPutAll: actualAttributeName
		].
	
		(RBSilentlyAddMethodRefactoring 
			model: anRBNamespace
			addMethod: methodSource
			toClass: className
			inProtocols: #(#accessing-attributes)) primitiveExecute ].
]

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> generateChildrenMethodForASTNodeClass: aClass in: anRBNamespace [
	| methodSource attributes lists relevantAttributes |
	attributes := aClass attributes reject: #hasClassScope.
	relevantAttributes := attributes select: [ :each | 
		each declaredType isStub not or: [ 
			each declaredType isParameterizedType and: [ 
				each declaredType name includesSubstring: 'List' ] ] ].
	relevantAttributes isEmpty ifTrue: [ ^ self ].
	lists := relevantAttributes select: [ :each | 
		each declaredType isParameterizedType and: [ 
			each declaredType name includesSubstring: 'List' ] ].
	methodSource := String streamContents: [ :s |
		s 
			nextPutAll: 'children'; cr;
			tab; nextPutAll: '| result |'; cr;
			tab; nextPutAll: 'result := super children.'; cr.
		relevantAttributes  
			do: [ :attribute | 
				(lists includes: attribute) 
					ifTrue: [ s 
						tab; 
						nextPutAll: 'result addAll: '; 
						nextPutAll: (self instVarNameForAttribute: attribute); 
						nextPutAll: '.';
						cr ]
					ifFalse: [ s 
						tab; 
						nextPutAll: (self instVarNameForAttribute: attribute); 
						nextPutAll: ' ifNotNil: [ :x | result add: x ].'; 
						cr ].
			].
		s tab; nextPutAll: '^ result'
	].
	(RBSilentlyAddMethodRefactoring 
		model: anRBNamespace
		addMethod: methodSource
		toClass: (self pharoClassName: aClass name) asSymbol
		inProtocols: #(#accessing)) primitiveExecute
]

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> generateClassFromASTNodeClass: aFAMIXClass in: anRBNamespace [
	(RBAddClassWithVarsRefactoring
		model: anRBNamespace
		addClass: (self pharoClassName: aFAMIXClass name)
		superclass: (self pharoClassName: aFAMIXClass superclass name)
		subclasses: {}
		category: #'Famix-PHP-AST')
			instanceVariableNames: (self attributeNamesForASTNodeClass: aFAMIXClass);
			primitiveExecute.
]

{ #category : #public }
GtPhpAstCodeGenerator >> generateFromPDTCoreModel: aModel [
	| namespace astNodeRoot |
	astNodeRoot := aModel allModelClasses
		entityNamed: #org::eclipse::php::core::ast::nodes::ASTNode.
	namespace := RBNamespace onEnvironment: RBBrowserEnvironment new.
	astNodeRoot withSubclassHierarchy
		do: [ :each | 
			(each name beginsWith: '?') ifFalse: [ 
				self generateClassFromASTNodeClass: each in: namespace.
				self addTraitUsageIfNecessaryToASTNodeClass: each in: namespace.
				self generateAccessorMethodsForASTNodeClass: each in: namespace.
				self generateInitializeMethodForASTNodeClass: each in: namespace.
				self generateChildrenMethodForASTNodeClass: each in: namespace ] ]
		displayingProgress: 'Generating AST classes'.
	self applyCustomRefactoringsIn: namespace.
	^ namespace changes
]

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> generateImportMethodForASTNodeClass: aClass in: namespace [
	| methodSource bodySource attributes lists |
	attributes := aClass attributes reject: #hasClassScope.
	lists := attributes select: [ :each |
		each declaredType isParameterizedType and: [ 
			each declaredType name includesSubstring: 'List' ] ].
	bodySource := String streamContents: [ :s |
		lists size = 1 ifTrue: [
			s
				tab; nextPutAll: 'anElement elements do: [ :subElement |'; cr;
				tab; tab; nextPutAll: '| child |'; cr;
				tab; tab; nextPutAll: 'child := (''GtPhp'', subElement localName) asClass new.'; cr;
				tab; tab; nextPutAll: 'child importFrom: subElement.'; cr;
				tab; tab; nextPutAll: lists anyOne name; nextPutAll: ' add: child.'; cr;
				tab; nextPutAll: '].'; cr
		].
		lists do: [ :attribute |
			s 
				tab; nextPutAll: 'anElement elementsAt: ''', (self xmlTagFromAttribute: attribute), ''' do: [ :subElement |'; cr;
				tab; tab; nextPutAll: 'subElement elements do: [ :subSubElement |'; cr;
				tab; tab; tab; nextPutAll: '| child |'; cr;
				tab; tab; tab; nextPutAll: 'child := (''GtPhp'', subSubElement localName) asClass new.'; cr;
				tab; tab; tab; nextPutAll: 'child importFrom: subSubElement.'; cr;
				tab; tab; tab; nextPutAll: (self instVarNameForAttribute: attribute); nextPutAll: ' add: child.'; cr;
				tab; tab; nextPutAll: '].'; cr;
				tab; nextPutAll: '].'; cr
		].
		((attributes \ lists) reject: [ :each | each declaredType isStub ]) do: [ :attribute |
			s
				tab; nextPutAll: 'anElement elementsAt: ''', (self xmlTagFromAttribute: attribute), ''' do: [ :subElement |'; cr;
				tab; tab; nextPutAll: 'subElement hasAttributes ifTrue: ['; cr;
				tab; tab; tab; nextPutAll: (self instVarNameForAttribute: attribute); nextPutAll: ' := #GtPhp', (self xmlTagFromAttribute: attribute), ' asClass new importFrom: subElement.'; cr;
				tab; tab; nextPutAll: ']'; cr;
				tab; tab; nextPutAll: 'ifFalse: ['; cr;
				tab; tab; tab; nextPutAll: (self instVarNameForAttribute: attribute); nextPutAll: ' := (#GtPhp, subElement localName) asSymbol asClass new importFrom: subElement.'; cr;
				tab; tab; nextPutAll: ']'; cr;
				tab; nextPutAll: '].'; cr
		] 
	].
	bodySource notEmpty ifTrue: [
		methodSource := String streamContents: [ :s |
			s nextPutAll: 'importFrom: anElement'; cr.
			s tab; nextPutAll: 'super importFrom: anElement.'; cr.
			s nextPutAll: bodySource
		].
		(RBSilentlyAddMethodRefactoring 
			model: namespace
			addMethod: methodSource
			toClass: (self pharoClassName: aClass name) asSymbol
			inProtocols: #(#importing)) primitiveExecute
	] 
]

{ #category : #'private - generation' }
GtPhpAstCodeGenerator >> generateInitializeMethodForASTNodeClass: aClass in: anRBNamespace [
	| methodSource attributes lists |
	attributes := aClass attributes reject: #hasClassScope.
	lists := attributes select: [ :each | 
		each declaredType isParameterizedType and: [ 
			each declaredType name includesSubstring: 'List' ] ].
	lists isEmpty ifTrue: [ ^ self ].
	methodSource := String streamContents: [ :s |
		s 
			nextPutAll: 'initialize'; cr;
			tab; nextPutAll: 'super initialize.'; cr.
		lists do: [ :listAttribute | 
			s 
				tab; 
				nextPutAll: (self instVarNameForAttribute: listAttribute), ' := OrderedCollection new.'; 
				cr ].
	].
	(RBSilentlyAddMethodRefactoring 
		model: anRBNamespace
		addMethod: methodSource
		toClass: (self pharoClassName: aClass name) asSymbol
		inProtocols: #(#initialization)) primitiveExecute
]

{ #category : #accesssing }
GtPhpAstCodeGenerator >> instVarNameForAttribute: attribute [
	"fNamespaceDeclaration should be namespaceDeclaration"
	^ ((attribute name beginsWith: 'f') and: [attribute name size > 1 and: [attribute name second isUppercase ]]) 
		ifTrue: [ (attribute name removePrefix: 'f') uncapitalized ]
		ifFalse: [ attribute name ]
]

{ #category : #accesssing }
GtPhpAstCodeGenerator >> pharoClassName: aString [
	^ ('GtPhp', aString) asSymbol
]

{ #category : #accesssing }
GtPhpAstCodeGenerator >> variablesRenames [
	^ variablesRenames ifNil: [ variablesRenames := {
	{#GtPhpNamespaceDeclaration. (#body -> #block)}.
	{#GtPhpNamespaceDeclaration. (#name -> #namespaceName)}.
	{#GtPhpTypeDeclaration. (#name -> #className)}.
	{#GtPhpTypeDeclaration. (#body -> #block)}.
	{#GtPhpClassDeclaration. (#superClass -> #superClassName)}.
	{#GtPhpMethodDeclaration. (#function -> #functionDeclaration)}.
	{#GtPhpFunctionDeclaration. (#body -> #functionBody)}.
	{#GtPhpFunctionDeclaration. (#name -> #functionName)}.
	{#GtPhpVariable. (#name -> #identifier)} .
	{#GtPhpScalar. (#stringValue -> #value)}. 
	{#GtPhpScalar. (#scalarType -> #type)}.
	{#GtPhpFormalParameter. (#parameterType -> #type)}.
	{#GtPhpAssignment. (#rightHandSide -> #value)} . 
	{#GtPhpAssignment. (#leftHandSide -> #variableBase)}.
	{#GtPhpMethodInvocation. (#method -> #property)}.
	{#GtPhpCastExpression. (#castingType -> #castType)}.
	{#GtPhpArrayAccess. (#arrayType -> #type)}.
	{#GtPhpClassInstanceCreation. (#ctorParams -> #constructorParameters)}.
	{#GtPhpFieldAccess. (#field -> #property)}.
	{#GtPhpLambdaFunctionDeclaration. (#body-> #functionBody)}.
	{#GtPhpForStatement. (#initializers -> #initializations)}.
	{#GtPhpTraitUseStatement. (#traitList -> #traitNameList)}.
	{#GtPhpQuote. (#quoteType -> #type)}.
	{#GtPhpForStatement. (#updaters -> #increasements)}.
	{#GtPhpSingleFieldDeclaration }. (#name -> #variableName).
	{#GtPhpSingleFieldDeclaration }. (#value -> #initialValue)
	} ]
	
]

{ #category : #accesssing }
GtPhpAstCodeGenerator >> xmlTagFromAttribute: attribute [
	^ (self instVarNameForAttribute: attribute) capitalized
]
