Class {
	#name : #FAMIXCPPImporter,
	#superclass : #Object,
	#instVars : [
		'asts',
		'model',
		'files',
		'folders',
		'currentFile',
		'classes',
		'enums',
		'structs',
		'unions',
		'aliases',
		'functions',
		'methods',
		'includeASTNodes',
		'parameterizedTypes',
		'unknownVariables',
		'annotations',
		'importPaths'
	],
	#category : #'Famix-CPP'
}

{ #category : #model }
FAMIXCPPImporter >> createAliasTypeNamed: aString for: aNode [
	| type |
	type := self ensureAliasTypeNamed: aString.
	type sourceAnchor: (self sourceAnchorFor: aNode).
	^ type
]

{ #category : #model }
FAMIXCPPImporter >> createClassNamed: aString for: aNode [
	| class |
	class := self ensureClassNamed: aString.
	class sourceAnchor: (self sourceAnchorFor: aNode).
	^ class
]

{ #category : #model }
FAMIXCPPImporter >> createEnumNamed: aString for: aNode [
	| class |
	class := self ensureEnumNamed: aString.
	class sourceAnchor: (self sourceAnchorFor: aNode).
	^ class
]

{ #category : #model }
FAMIXCPPImporter >> createEnumValueNamed: aString in: anEnum for: aNode [
	| value |
	value := FAMIXEnumValue new.
	model add: value.
	value name: aString.
	value sourceAnchor: (self sourceAnchorFor: aNode).
	value parentEnum: anEnum.
	^ value
]

{ #category : #model }
FAMIXCPPImporter >> createFunctionNamed: aString for: aNode [
	| function |
	function := self ensureFunctionNamed: aString.
	function sourceAnchor: (self sourceAnchorFor: aNode).
	(functions at: aString ifAbsentPut: [ OrderedCollection new ])
		add: function.
	^ function
]

{ #category : #model }
FAMIXCPPImporter >> createLambdaNamed: aString in: outerMethod for: aNode [
	| lambda |
	lambda := self ensureLambdaNamed: aString.
	outerMethod notNil
		ifTrue: [ lambda outerMethod: outerMethod ].
	aNode notNil
		ifTrue: [ lambda sourceAnchor: (self sourceAnchorFor: aNode) ].
	^ lambda
]

{ #category : #model }
FAMIXCPPImporter >> createMethodNamed: aString in: anObject for: aNode [
	| method |
	method := self ensureMethodNamed: aString.
	aNode notNil
		ifTrue: [ method sourceAnchor: (self sourceAnchorFor: aNode) ].
	anObject notNil
		ifTrue: [ anObject addMethod: method ].
	(methods at: aString ifAbsentPut: [ OrderedCollection new ])
		add: method.
	^ method
]

{ #category : #model }
FAMIXCPPImporter >> createStructNamed: aString for: aNode [
	| struct |
	struct := self ensureStructNamed: aString.
	struct sourceAnchor: (self sourceAnchorFor: aNode).
	^ struct
]

{ #category : #model }
FAMIXCPPImporter >> createTemplateClassNamed: aString for: aNode [
	| class |
	class := self ensureTemplateClassNamed: aString.
	class sourceAnchor: (self sourceAnchorFor: aNode).
	^ class
]

{ #category : #model }
FAMIXCPPImporter >> createTemplateStructNamed: aString for: aNode [
	| struct |
	struct := self ensureTemplateStructNamed: aString.
	struct sourceAnchor: (self sourceAnchorFor: aNode).
	^ struct
]

{ #category : #model }
FAMIXCPPImporter >> createUnionNamed: aString for: aNode [
	| union |
	union := self ensureUnionNamed: aString.
	union sourceAnchor: (self sourceAnchorFor: aNode).
	^ union
]

{ #category : #accessing }
FAMIXCPPImporter >> currentFile [
	^ currentFile
]

{ #category : #importing }
FAMIXCPPImporter >> declarationVisitor [
	| visitor |
	visitor := FAMIXCPPDeclarationImportingVisitor new.
	visitor importer: self.
	^ visitor
]

{ #category : #model }
FAMIXCPPImporter >> ensureAliasTypeNamed: aString [
	^ aliases
		at: aString trim
		ifAbsentPut: [ model
				add: (FAMIXTypeAlias new name: (self removeNamespaceFrom: aString)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureAnnotationNamed: aString [
	^ annotations
		at: aString
		ifAbsentPut: [ model add: (FAMIXAnnotationType new name: aString) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureClassNamed: aString [
	| string |
	string := self removeConst: aString.
	^ classes
		at: string
		ifAbsentPut:
			[ model add: (FAMIXClass new name: (self removeNamespaceFrom: string)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureEnumNamed: aString [
	^ enums
		at: aString trim
		ifAbsentPut:
			[ model add: (FAMIXEnum new name: (self removeNamespaceFrom: aString)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureFileNamed: aFileReference [
	| filename |
	filename := aFileReference pathString.
	DiskStore activeClass isCaseSensitive
		ifFalse: [ filename := filename asUppercase ].
	^ files
		at: filename
		ifAbsentPut: [ | file |
			file := FAMIXCFile new.
			file name: aFileReference basename.
			aFileReference exists
				ifTrue: [ | encoding anchor |
					encoding := [ aFileReference
						binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
						on: ZnCharacterEncodingError
						do: [ :ex | ex return: 'utf-8' ].
					anchor := FAMIXIndexedFileEntityAnchor
						file: file
						startPos: 1
						endPos:
							(aFileReference
								readStreamEncoded: encoding
								do: [ :stream | stream contents size ])
						model: model.
					file sourceAnchor: anchor ]
				ifFalse: [ file isStub: true ].
			model add: file.
			file ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureFolderNamed: aFileReference [
	^ folders
		at: aFileReference pathString
		ifAbsentPut: [ | folder |
			folder := FAMIXFolder new.
			aFileReference = model rootFolder
				ifTrue: [ folder name: '.' ]
				ifFalse: [ folder name: aFileReference basename.
					(self ensureFolderNamed: aFileReference parent)
						ifNotNil: [ :outer | outer addChildFileSystemEntity: folder ] ].
			model add: folder.
			folder ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureFunctionNamed: aString [
	^ model add: (FAMIXFunction new name: aString)
]

{ #category : #model }
FAMIXCPPImporter >> ensureLambdaNamed: aString [
	^ model add: (FAMIXCPPLambda new name: aString)
]

{ #category : #model }
FAMIXCPPImporter >> ensureMethodNamed: aString [
	^ model add: (FAMIXCPPMethod new name: aString)
]

{ #category : #model }
FAMIXCPPImporter >> ensureNamespace: aString in: aNamespace [
	| namespace |
	namespace := aNamespace isNil
		ifTrue: [ model allNamespaces
				detect: [ :each | each parentScope isNil and: [ each name = aString ] ]
				ifNone: [  ] ]
		ifFalse: [ aNamespace childScopes
				detect: [ :each | each name = aString ]
				ifNone: [  ] ].
	namespace isNil
		ifTrue: [ namespace := FAMIXNamespace new.
			namespace name: aString.
			model add: namespace.
			aNamespace notNil
				ifTrue: [ aNamespace addChildScope: namespace ] ].
	^ namespace
]

{ #category : #model }
FAMIXCPPImporter >> ensureParameterizedStructFor: aParameterableType with: typeArgs [
	^ parameterizedTypes
		at:
			{aParameterableType.
			typeArgs}
		ifAbsentPut: [ | type |
			type := FAMIXParameterizedStruct new
				parameterizableStruct: aParameterableType;
				name: aParameterableType name;
				arguments: typeArgs.
			model add: type ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureParameterizedTypeFor: aParameterableType with: typeArgs [
	^ parameterizedTypes
		at:
			{aParameterableType.
			typeArgs asArray}
		ifAbsentPut: [ | type |
			type := FAMIXParameterizedType new
				parameterizableClass: aParameterableType;
				name: aParameterableType name;
				arguments: typeArgs.
			model add: type ]
]

{ #category : #model }
FAMIXCPPImporter >> ensurePrimitiveTypeNamed: aString [
	^ structs
		at: aString
		ifAbsentPut: [ model add: (FAMIXPrimitiveType new name: aString) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureStructNamed: aString [
	| string |
	string := self removeConst: aString.
	^ structs
		at: string
		ifAbsentPut: [ model
				add: (FAMIXCPPStruct new name: (self removeNamespaceFrom: string)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureTemplateClassNamed: aString [
	| string |
	string := self removeConst: aString.
	^ classes
		at: string
		ifAbsentPut: [ model
				add:
					(FAMIXParameterizableClass new
						name: (self removeNamespaceFrom: string)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureTemplateStructNamed: aString [
	| string |
	string := self removeConst: aString.
	^ structs
		at: string
		ifAbsentPut: [ model
				add:
					(FAMIXParameterizableCPPStruct new
						name: (self removeNamespaceFrom: string)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureUnionNamed: aString [
	| string |
	string := self removeConst: aString.
	^ unions
		at: string
		ifAbsentPut: [ model
				add: (FAMIXCPPUnion new name: (self removeNamespaceFrom: string)) ]
]

{ #category : #model }
FAMIXCPPImporter >> ensureUnknownVariableNamed: aString [
	^ unknownVariables
		at: aString
		ifAbsentPut: [ model add: (FAMIXUnknownVariable new name: aString) ]
]

{ #category : #importing }
FAMIXCPPImporter >> filesOfType: anExtensionPattern in: aDirectory excluding: exclusionPatterns do: aBlock [
	(aDirectory filesMatching: anExtensionPattern)
		do: [ :each | 
			(exclusionPatterns
				noneSatisfy: [ :pattern | pattern match: each basename ])
				ifTrue: [ aBlock value: each ] ].
	aDirectory directories
		do: [ :each | 
			(exclusionPatterns
				noneSatisfy: [ :pattern | pattern match: each basename ])
				ifTrue: [ self
						filesOfType: anExtensionPattern
						in: each
						excluding: exclusionPatterns
						do: aBlock ] ]
]

{ #category : #importing }
FAMIXCPPImporter >> finishImport [
	asts := OrderedCollection new.
	currentFile := nil
]

{ #category : #model }
FAMIXCPPImporter >> functionsNamed: aString [
	^ functions at: aString ifAbsent: [ #() ]
]

{ #category : #importing }
FAMIXCPPImporter >> importDeclarations [
	asts
		do: [ :each | self importDeclarationsFrom: each ]
		displayingProgress: [ :each | 
			'Importing declarations from '
				, (each filename ifNil: [ '' ] ifNotNil: [ :fn | fn basename ]) ]
]

{ #category : #importing }
FAMIXCPPImporter >> importDeclarationsFrom: anAST [
	| folder filename |
	filename := anAST attributeNamed: #filename.
	folder := self ensureFolderNamed: filename parent.
	currentFile := self ensureFileNamed: filename.
	folder addChildFileSystemEntity: currentFile.
	anAST attributeNamed: #famixFile put: currentFile.
	self storeAST: anAST into: currentFile.
	self declarationVisitor accept: anAST
]

{ #category : #importing }
FAMIXCPPImporter >> importFrom: aDirectory [
	self importFrom: aDirectory excluding: #()
]

{ #category : #importing }
FAMIXCPPImporter >> importFrom: aDirectory excluding: patternCollection [
	self importPaths isEmpty
		ifTrue: [ self importPaths: {aDirectory asFileReference} ].
	model rootFolder: aDirectory asFileReference.
	self parseFilesIn: aDirectory excluding: patternCollection.
	self importDeclarations.
	self importVariables.
	self importReferences.
	self finishImport
]

{ #category : #accessing }
FAMIXCPPImporter >> importPaths [
	^ importPaths ifNil: [ #() ]
]

{ #category : #accessing }
FAMIXCPPImporter >> importPaths: aCollection [
	importPaths := aCollection
]

{ #category : #importing }
FAMIXCPPImporter >> importReferences [
	asts
		do: [ :each | self importReferencesFrom: each ]
		displayingProgress: [ :each | 
			'Importing references from '
				, (each filename ifNil: [ '' ] ifNotNil: [ :fn | fn basename ]) ]
]

{ #category : #importing }
FAMIXCPPImporter >> importReferencesFrom: anAST [
	currentFile := anAST attributeNamed: #famixFile.
	self referencesVisitor accept: anAST
]

{ #category : #importing }
FAMIXCPPImporter >> importVariables [
	asts
		do: [ :each | self importVariablesFrom: each ]
		displayingProgress: [ :each | 
			'Importing variables from '
				, (each filename ifNil: [ '' ] ifNotNil: [ :fn | fn basename ]) ]
]

{ #category : #importing }
FAMIXCPPImporter >> importVariablesFrom: anAST [
	currentFile := anAST attributeNamed: #famixFile.
	self variablesVisitor accept: anAST
]

{ #category : #accessing }
FAMIXCPPImporter >> includeASTNodes [
	^ includeASTNodes
]

{ #category : #accessing }
FAMIXCPPImporter >> includeASTNodes: aBoolean [
	includeASTNodes := aBoolean
]

{ #category : #initialization }
FAMIXCPPImporter >> initialize [
	super initialize.
	model := MooseModel new.
	model
		sourceLanguage:
			(FAMIXPreprocessedCppSourceLanguage new
				preprocessor: self preprocessor).
	classes := Dictionary new.
	enums := Dictionary new.
	structs := Dictionary new.
	unions := Dictionary new.
	aliases := Dictionary new.
	files := Dictionary new.
	folders := Dictionary new.
	functions := Dictionary new.
	methods := Dictionary new.
	asts := OrderedCollection new.
	includeASTNodes := true.
	parameterizedTypes := Dictionary new.
	unknownVariables := Dictionary new.
	annotations := Dictionary new
]

{ #category : #private }
FAMIXCPPImporter >> lookupType: aString from: aNode importedNamespaces: importedNamespaces importedNames: importedNames [
	| name nsName |
	nsName := self namespaceNameFor: aNode.
	name := self
		removeGenericsFrom: (nsName ifEmpty: [ aString ] ifNotEmpty: [ :s | s , '::' , aString ]).
	(self typeNamed: name) ifNotNil: [ :cls | ^ cls ].
	importedNames
		at: aString
		ifPresent: [ :item | 
			(self typeNamed: (self removeGenericsFrom: item))
				ifNotNil: [ :cls | ^ cls ] ].
	importedNamespaces
		do: [ :each | 
			(self typeNamed: (self removeGenericsFrom: each , '::' , aString))
				ifNotNil: [ :cls | ^ cls ] ].
	((self typeNamed: aString)
		ifNil: [ self typeNamed: (self removeGenericsFrom: aString) ])
		ifNotNil: [ :cls | ^ cls ].
	(self typesWithName: (self removeGenericsFrom: aString))
		ifNotEmpty: [ :typesWithName | 
			typesWithName size = 1
				ifTrue: [ ^ typesWithName anyOne ] ].
	^ nil
]

{ #category : #model }
FAMIXCPPImporter >> methodsNamed: aString [
	^ methods at: aString ifAbsent: [ #() ]
]

{ #category : #accessing }
FAMIXCPPImporter >> model [
	^ model
]

{ #category : #private }
FAMIXCPPImporter >> namespaceNameFor: aNode [
	| current name |
	aNode isNil
		ifTrue: [ ^ '' ].
	current := aNode.
	name := ''.
	[ (current := current
		parentOfType:
			{CPPOriginalNamespaceDefinitionNode.
			CPPClassSpecifierNode}) notNil ]
		whileTrue: [ | parentName |
			parentName := (current isKindOf: CPPOriginalNamespaceDefinitionNode)
				ifTrue: [ String
						streamContents: [ :stream | 
							current names
								do: [ :each | stream nextPutAll: each source ]
								separatedBy: [ stream nextPutAll: '::' ] ] ]
				ifFalse: [ current name
						ifNotNil: [ :token | 
							(current nameSpecifier ifNil: [ '' ] ifNotNil: [ :ns | ns source ])
								, token source ] ].
			parentName notNil
				ifTrue: [ name := parentName
						,
							(name isEmpty
								ifTrue: [ '' ]
								ifFalse: [ '::' , name ]) ] ].
	^ name
]

{ #category : #importing }
FAMIXCPPImporter >> parseFile: aFileReference [
	| preprocessedFile ast |
	preprocessedFile := self preprocess: aFileReference.
	ast := CPPParser parseWithErrors: preprocessedFile sourceString.
	ast attributeNamed: #preprocessedFile put: preprocessedFile.
	ast attributeNamed: #filename put: aFileReference.
	^ ast
]

{ #category : #importing }
FAMIXCPPImporter >> parseFilesIn: aDirectory excluding: patternCollection [
	#('*.h' '*.cpp' '*.c')
		do: [ :each | 
			self
				filesOfType: each
				in: aDirectory asFileReference
				excluding: patternCollection
				do: [ :fn | asts add: (self parseFile: fn) ] ]
]

{ #category : #private }
FAMIXCPPImporter >> preprocess: aFileReference [
	| preprocessor |
	preprocessor := self preprocessor.
	preprocessor processFile: aFileReference.
	^ preprocessor preprocessedFile
]

{ #category : #private }
FAMIXCPPImporter >> preprocessor [
	^ CPPPreprocessor new
]

{ #category : #importing }
FAMIXCPPImporter >> referencesVisitor [
	| visitor |
	visitor := FAMIXCPPReferencesImportingVisitor new.
	visitor importer: self.
	^ visitor
]

{ #category : #private }
FAMIXCPPImporter >> removeConst: aString [
	| string |
	string := aString trim.
	string size > 6
		ifFalse: [ ^ string ].
	((string beginsWith: 'const') and: [ (string at: 6) isSeparator ])
		ifTrue: [ string := (string allButFirst: 6) trim ].
	^ string
]

{ #category : #private }
FAMIXCPPImporter >> removeGenericsFrom: aString [
	((aString includes: $<)
		or: [ (aString includes: $ ) or: [ aString beginsWith: '::' ] ])
		ifFalse: [ ^ aString ].
	^ String
		streamContents: [ :stream | 
			| inStream count |
			inStream := (aString copyWithout: $ ) readStream.
			2 timesRepeat: [ inStream peekFor: $: ].
			[ inStream atEnd ]
				whileFalse: [ stream nextPutAll: (inStream upTo: $<).
					count := 1.
					[ count > 0 ]
						whileTrue: [ count := count + ((inStream upTo: $>) occurrencesOf: $<) - 1 ] ] ]
]

{ #category : #private }
FAMIXCPPImporter >> removeNamespaceFrom: aString [
	| index |
	index := aString lastIndexOf: $:.
	^ (index > 0
		ifTrue: [ aString allButFirst: index ]
		ifFalse: [ aString ]) trim
]

{ #category : #model }
FAMIXCPPImporter >> sourceAnchorFor: aNode [
	^ self
		sourceAnchorFor: aNode
		from: aNode startPosition
		to: aNode stopPosition
]

{ #category : #model }
FAMIXCPPImporter >> sourceAnchorFor: aNode from: start to: stop [
	| preprocessedFile topParent anchor |
	topParent := aNode topParent.
	preprocessedFile := topParent attributeNamed: #preprocessedFile.
	anchor := FAMIXIndexedFileEntityAnchor
		file: self currentFile
		startPos: (preprocessedFile startPositionFor: start)
		endPos: (preprocessedFile stopPositionFor: stop)
		model: model.
	^ anchor
]

{ #category : #private }
FAMIXCPPImporter >> storeAST: aNode into: anEntity [
	includeASTNodes
		ifTrue: [ anEntity propertyNamed: #ast put: aNode ]
]

{ #category : #model }
FAMIXCPPImporter >> typeNamed: aString [
	self typeVariables
		do:
			[ :each | (each at: aString ifAbsent: [  ]) ifNotNil: [ :type | ^ type ] ].
	^ nil
]

{ #category : #private }
FAMIXCPPImporter >> typeVariables [
	^ {classes.
	structs.
	enums.
	unions}
]

{ #category : #model }
FAMIXCPPImporter >> typesWithName: aString [
	| result |
	result := Set new.
	self typeVariables
		do: [ :each | 
			each
				keysAndValuesDo: [ :key :value | 
					(key endsWith: '::' , aString)
						ifTrue: [ result add: value ] ] ].
	^ result
]

{ #category : #importing }
FAMIXCPPImporter >> variablesVisitor [
	| visitor |
	visitor := FAMIXCPPVariableImportingVisitor new.
	visitor importer: self.
	^ visitor
]
