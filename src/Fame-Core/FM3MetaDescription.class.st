"
A FM3MetaDescription describes a class in FM3.
It is composed of 
	FM3PropertyDescription which may be a package extension
	
A FM3MetaDescription is contained in a FM3PackageDescription.
	
FM3Property should be managed 

Note that it should be renamed FM3Class to be in sync with the rest of the documents.
"
Class {
	#name : #FM3MetaDescription,
	#superclass : #FM3Element,
	#instVars : [
		'isAbstract',
		'superclass',
		'package',
		'attributes',
		'implementingClass',
		'subclasses'
	],
	#classInstVars : [
		'object',
		'boolean',
		'number',
		'string'
	],
	#category : #'Fame-Core'
}

{ #category : #meta }
FM3MetaDescription class >> annotation [
	<MSEClass: #Class super: #FM3Element>
	<package: #FM3>

]

{ #category : #constants }
FM3MetaDescription class >> boolean [

	boolean isNil ifTrue: [ 
		boolean := self booleanClass basicNew.
		boolean initialize.
		boolean name: #Boolean.
		"FM3Boolean beImmutable" ].
	^boolean
]

{ #category : #'private-anonymous classes' }
FM3MetaDescription class >> booleanClass [

	| class |
	class := Class new.
	self setSuperclassClassOf: class.
	class setFormat: self format.
	class methodDict: MethodDictionary new.
	class methodDict at: #isPrimitive put: (self methodNamed: #anonymousReturnTrue).
	class setName: 'AnonymousClass'.
	^class
]

{ #category : #constants }
FM3MetaDescription class >> constantsDo: aBlock [

	aBlock value: self boolean.
	aBlock value: self number.
	aBlock value: self object.
	aBlock value: self string.
]

{ #category : #examples }
FM3MetaDescription class >> gtExampleBasic [
	<gtExample>
	^ self new
]

{ #category : #examples }
FM3MetaDescription class >> gtExampleWithOnePrimitiveProperty: description [
	<gtExample>
	<depends: #gtExampleBasic>
	^ description attributes add: FM3PropertyDescription new
]

{ #category : #constants }
FM3MetaDescription class >> number [

	number isNil ifTrue: [ 
		number := self numberClass basicNew.
		number initialize.
		number name: #Number.
		"FM3Number beImmutable" ].
	^number
]

{ #category : #'private-anonymous classes' }
FM3MetaDescription class >> numberClass [

	| class |
	class := Class new.
	self setSuperclassClassOf: class.
	class setFormat: self format.
	class methodDict: MethodDictionary new.
	class methodDict at: #isPrimitive put: (self methodNamed: #anonymousReturnTrue).
	class setName: 'AnonymousClass'.
	^class
]

{ #category : #constants }
FM3MetaDescription class >> object [

	object isNil ifTrue: [ 
		object := self objectClass basicNew.
		object initialize.
		object superclass: nil.
		object name: #Object.
		"FM3Object beImmutable" ].
	^object
]

{ #category : #'private-anonymous classes' }
FM3MetaDescription class >> objectClass [

	| class |
	class := Class new.
	self setSuperclassClassOf: class.
	class setFormat: self format.
	class methodDict: MethodDictionary new.
	class methodDict at: #isRoot put: (self  methodNamed: #anonymousReturnTrue).
	class setName: 'AnonymousClass'.
	^class
]

{ #category : #private }
FM3MetaDescription class >> privateOnlyCallMeIfYourAreBDFLOrSystemAdminFromHellFlush [
	"
	self privateOnlyCallMeIfYourAreBDFLOrSystemAdminFromHellFlush
	"
	string := nil.
	number := nil.
	object := nil.
	boolean := nil.
]

{ #category : #'private-anonymous classes' }
FM3MetaDescription class >> setSuperclassClassOf: class [
	"This method is an hack I do to correct a change in Pharo 7 since Moose will soon get a new stable version with the project MooseNG."

	SystemVersion current major < 7
		ifTrue: [ class superclass: self ]
		ifFalse: [ class basicSuperclass: self ]
]

{ #category : #constants }
FM3MetaDescription class >> string [

	string isNil ifTrue: [ 
		string := self stringClass basicNew.
		string initialize.
		string name: #String.
		"FM3String beImmutable" ].
	^string
]

{ #category : #'private-anonymous classes' }
FM3MetaDescription class >> stringClass [

	| class |
	class := Class new.
	self setSuperclassClassOf: class.
	class setFormat: self format.
	class methodDict: MethodDictionary new.
	class methodDict at: #isPrimitive put: (self methodNamed: #anonymousReturnTrue).
	class setName: 'AnonymousClass'.
	^class
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allAttributes [
	<MSEProperty: #allAttributes type: 'FM3.Property'>
	<multivalued>
	<derived>
	
	| nameDict |
	nameDict := Dictionary new: 60. "estimated initial size."
	self allAttributesDo: [ :each |
		nameDict at: each name ifAbsentPut: [ each ]].
	^Array withAll: nameDict values
]

{ #category : #enumerating }
FM3MetaDescription >> allAttributesDo: block [
	
	attributes do: block.
	self superclass notNil ifTrue: [
		self superclass allAttributesDo: block ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allAttributesNotDerived [
	^ self allAttributes reject: [ :attr | attr isDerived ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allComplexAttributes [

	^ self allAttributes reject: [:attr | attr type isPrimitive ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allComplexAttributesNotDerived [
	^ self allAttributes reject: [ :attr | attr type isPrimitive or: [ attr isDerived ] ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allComplexAttributesWithOpposite [
	^ self allAttributes reject: [ :attr | attr type isPrimitive or: [ attr hasOpposite not ] ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allContainerAttributes [
	^ self allAttributes select: #isContainer
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allPrimitiveAttributes [

	^ self allAttributes select: [:attr | 
		attr type notNil and: [attr type isPrimitive ]]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> allPrimitiveAttributesNotDerived [
	^ self allAttributes select: [ :attr | attr type notNil and: [ attr type isPrimitive and: [ attr isDerived not ] ] ]
]

{ #category : #accessing }
FM3MetaDescription >> allSubclasses [

	| all |
	all := OrderedCollection new.
	self allSubclassesDo: [:each | all add: each ].
	^ all
]

{ #category : #accessing }
FM3MetaDescription >> allSubclassesDo: aBlock [

	self subclasses do: [:each | 
		aBlock value: each.
		each allSubclassesDo: aBlock ]
]

{ #category : #accessing }
FM3MetaDescription >> allSuperclasses [

	| mmclass superclasses |
	
	superclasses := OrderedCollection new.
	mmclass := self.
	
	[mmclass hasSuperclass]
		whileTrue: [
			mmclass := mmclass superclass.
			superclasses add: mmclass].
	^ superclasses
]

{ #category : #accessing }
FM3MetaDescription >> allSuperclassesDo: aBlock [
	self allSuperclasses do: [ :each | aBlock value: each ]
]

{ #category : #'private-anonymous behaviour' }
FM3MetaDescription >> anonymousReturnTrue [
	^true
]

{ #category : #'accessing-query' }
FM3MetaDescription >> at: aString [
	aString isSymbol ifTrue: [ self error ].
	^ self attributeNamed: aString
]

{ #category : #'accessing-query' }
FM3MetaDescription >> attributeNamed: aString [

	^self attributeNamed: aString ifAbsent: nil
]

{ #category : #'accessing-query' }
FM3MetaDescription >> attributeNamed: aString ifAbsent: aBlock [
	"Cyril: I remove the #asString because it is longer to convert it ourself than to let the = manage it."

	self attributes
		do: [ :each | (each name sameContentAs: aString) ifTrue: [ ^ each ] ].

	^ self superclass
		ifNil: [ aBlock value ]
		ifNotNil: [ :sc | sc attributeNamed: aString ifAbsent: aBlock ]
]

{ #category : #accessing }
FM3MetaDescription >> attributes [
	<MSEProperty: #attributes type: 'FM3.Property' opposite: #class>
	<multivalued>
	<key: #name>
	
	^attributes
]

{ #category : #accessing }
FM3MetaDescription >> attributes: anObject [

	attributes value: anObject
]

{ #category : #'accessing-query' }
FM3MetaDescription >> attributesNamed: aListOfSymbol [
	
	^ aListOfSymbol collect: [ :each | self attributeNamed: each ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> complexAttributes [

	^ self attributes reject: [:attr | attr type isPrimitive ]
]

{ #category : #'instance creation' }
FM3MetaDescription >> createInstance [

	^implementingClass isNil
		ifTrue: [ FMRuntimeElement new description: self ]
		ifFalse: [ implementingClass new ]
]

{ #category : #private }
FM3MetaDescription >> defaultClassName [

	^ (self package name, self name) asSymbol 
]

{ #category : #ui }
FM3MetaDescription >> gtInspectorPropertiesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite table
		title: [ self allPrimitiveAttributes size asString , ' Properties' translated ];
		display: [ self allPrimitiveAttributes ];
		sorted: [:attribute1 :attribute2 | attribute1 name < attribute2 name];
		column: 'name' evaluated: [:each | each name ] tags: [ :each :aFM3Class | 
					each mmClass ~= aFM3Class
						ifTrue: [ each mmClass name ]
						ifFalse: [ OrderedCollection new ] ];
		column: 'type' evaluated: [:each | each gtTypeString];
		column: 'derived?' evaluated: [ :each | each isDerived ] width: 50 ;
		when: [ self allComplexAttributes notEmpty ];
		morphicSelectionAct: [ :list | 
							Smalltalk tools browser 
								openOnClass: list selection mmClass implementingClass 
								selector: list selection implementingSelector ] 
							icon: GLMUIThemeExtraIcons glamorousBrowse 
							on: $b
							entitled: 'Browse implementation';
		morphicSelectionAct: [ :list | list selection inspect ] icon: Smalltalk ui icons glamorousInspect entitled: 'Inspect'
]

{ #category : #accessing }
FM3MetaDescription >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Properties' translated;
		items: [ self allPrimitiveAttributes sorted: [:attribute1 :attribute2 | attribute1 name < attribute2 name] ];
		column: 'Name' text: [:each | each name ];
		column: 'Type' text: [:each | each gtTypeString];
		column: 'Derived?' text: [ :each | each isDerived ] width: 50
]

{ #category : #accessing }
FM3MetaDescription >> gtRelationsFor: aView [
	<gtView>
	^ aView columnedList 
			title: 'Relations' translated; 
			items: [ self allComplexAttributes sorted: [ :attribute1 :attribute2 | attribute1 name < attribute2 name ]]; 
			column: 'Name' text: [ :each | each name ];
			column: 'Type' text: [ :each | each gtTypeString ]; 
			column: 'Opposite' text: [ :each | each opposite ifNil: [ '' ] ifNotNil: [ :opposite | opposite name ] ]; 
			column: 'Derived?' text: [ :each | each isDerived ] width: 50; 
			column: 'Container?' text: [ :each | each isContainer ] width: 50; 
			column: 'IsTarget?' text: [ :each | each isTarget ] width: 50;
			column: 'IsSource?' text: [ :each | each isSource ] width: 50
			"selectionPopulate: #selection
			on: $o
			entitled: 'Open opposite'
			with: [ :list | list selection opposite ]; morphicSelectionAct: [ :list | 
				Smalltalk tools browser
					openOnClass: list selection mmClass implementingClass
					selector: list selection implementingSelector ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse implementation'; "
]

{ #category : #accessing }
FM3MetaDescription >> gtTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Tree';
		painting: [ :m | 
			m nodes
				umlClassShapeWithName: [ :each | each name asRopedText ];
				with: self withAllSuperclasses , self allSubclasses
					forEach: [ :each | 
						m nodes
							stencil: [ :a | 
								| pane |
								pane := BrHorizontalPane new
										vFitContent;
										hFitContent;
										addChild: (BrLabel new
												text: a name , ':';
												when: BlClickEvent do: [ :e | e target phlow spawnObject: a ]);
										addChild: (BrLabel new
												text: a type name;
												aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
												when: BlClickEvent do: [ :e | e target phlow spawnObject: a type ]).
								a hasOpposite
									ifTrue: [ pane
											addChild: (BrLabel new
													text: '(' , a opposite name , ')';
													aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
													when: BlClickEvent
														do: [ :e | e target phlow spawnObject: a opposite ]) ].
								pane ];
							with: (each attributes sorted: [ :a :b | a name < b name ]).
						m layout vertical ].
			m edges
				stencil: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
						fromHead: (BlArrowheadTriangle new
								scale: 4;
								border: (BlBorder paint: (Color gray alpha: 0.5))) ];
				fromCenterBottom;
				toCenterTop;
				connectFrom: #superclass.
			m layout tree levelDistance: 30 ]
]

{ #category : #testing }
FM3MetaDescription >> hasImplementingClass [
	^ implementingClass notNil
]

{ #category : #testing }
FM3MetaDescription >> hasOwner [
	^ self hasPackage
]

{ #category : #testing }
FM3MetaDescription >> hasPackage [
	^package notNil
]

{ #category : #testing }
FM3MetaDescription >> hasSuperclass [
	^ superclass isNil not
]

{ #category : #private }
FM3MetaDescription >> implementingClass [
	
	^implementingClass
]

{ #category : #accessing }
FM3MetaDescription >> inheritsFrom: aClass [
	self
		allSuperclassesDo: [ :each | 
			each = aClass
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'initialize-release' }
FM3MetaDescription >> initialize [

	attributes := FMMultivalueLink on: self opposite: #mmClass:.
	package := nil.
	isAbstract := false.
	superclass := FM3 object. FM3 note: 'Not sure if this is valid, maybe, superclass must be nil?'.
	subclasses := FMMultivalueLink on: self opposite: #superclass:.

]

{ #category : #accessing }
FM3MetaDescription >> isAbstract [
	<MSEProperty: #abstract type: #'Boolean'>
	^isAbstract
]

{ #category : #accessing }
FM3MetaDescription >> isAbstract: anObject [
	isAbstract := anObject
]

{ #category : #testing }
FM3MetaDescription >> isAssociation [
	^ self allSuperclasses anySatisfy: [ :aSuperclass | aSuperclass name = #Association ]
]

{ #category : #testing }
FM3MetaDescription >> isBuiltIn [
	^self isPrimitive or: [ self isRoot ]
]

{ #category : #testing }
FM3MetaDescription >> isFM3Class [
	^true
]

{ #category : #'accessing-query' }
FM3MetaDescription >> isPrimitive [
	<MSEProperty: #primitive type: #'Boolean'>
	<derived>

	^false
]

{ #category : #'accessing-query' }
FM3MetaDescription >> isRoot [
	<MSEProperty: #root type: #'Boolean'>
	<derived>

	^false
]

{ #category : #accessing }
FM3MetaDescription >> owner [
	^self package
]

{ #category : #'accessing-query' }
FM3MetaDescription >> ownerAttribute [
	self flag: #FIXME.
	self flag: 'It is possible that several containers exists for a given entity -> we have not a tree, but we should not get cycles at ALL'.
	^self allAttributes detect: #isContainer ifNone: [ nil ]
]

{ #category : #'accessing-query' }
FM3MetaDescription >> ownerAttributes [

	^self allAttributes select: #isContainer 
]

{ #category : #accessing }
FM3MetaDescription >> package [
	<MSEProperty: #package type: #FM3PackageDescription opposite: #classes>
	<container>
	
	^package
]

{ #category : #accessing }
FM3MetaDescription >> package: newPackage [
	
	package := FMMultivalueLink on: self
					update: #classes
					from: self package
					to: newPackage
]

{ #category : #accessing }
FM3MetaDescription >> packageName [

	^ self package name
]

{ #category : #'accessing-query' }
FM3MetaDescription >> primitiveAttributes [

	^ self attributes select: [:attr | attr type isPrimitive ]
]

{ #category : #private }
FM3MetaDescription >> setImplementingClass: smalltalkClass [
	implementingClass := smalltalkClass
]

{ #category : #accessing }
FM3MetaDescription >> subclasses [ 
	<MSEProperty: #subclasses type: #FM3MetaDescription opposite: #superclass>
	<derived>
	<multivalued>
	^subclasses
]

{ #category : #accessing }
FM3MetaDescription >> subclasses: anObject [

	subclasses value: anObject
]

{ #category : #accessing }
FM3MetaDescription >> superclass [
	<MSEProperty: #superclass type: #FM3MetaDescription opposite: #subclasses>
	^superclass
]

{ #category : #accessing }
FM3MetaDescription >> superclass: newClass [

	superclass := FMMultivalueLink on: self
					update: #subclasses
					from: self superclass
					to: newClass
]

{ #category : #testing }
FM3MetaDescription >> todo [

	self flag: #renameFM3MetaDescriptionIntoFM3Class.
	self flag: #superInvocationInInitialize.
]

{ #category : #accessing }
FM3MetaDescription >> withAllSubclasses [
	^ self allSubclasses
		add: self;
		yourself
]

{ #category : #accessing }
FM3MetaDescription >> withAllSuperclasses [
	^ self allSuperclasses
		add: self;
		yourself
]

{ #category : #accessing }
FM3MetaDescription >> withSuperclassesDo: aBlock [
	aBlock value: self.
	self allSuperclassesDo: aBlock
]
