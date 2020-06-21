"
!Loading in Moose

[[[
	| importer |
	importer := self new 
		mooseModel: aModel;
		importFromXml: 
'<symfony-project>/var/cache/dev/appDevDebugProjectContainer.xml' asFileReference.
	importer
]]]
"
Class {
	#name : #GtPhpSymfonyImporter,
	#superclass : #Object,
	#instVars : [
		'services',
		'mooseModel'
	],
	#category : #'Famix-PHP-Symfony'
}

{ #category : #importing }
GtPhpSymfonyImporter >> ensureServiceNamed: aString [
	^ services 
		at: aString asSymbol
		ifAbsentPut: [ GtPhpSymfonyService new name: aString asSymbol ]
]

{ #category : #importing }
GtPhpSymfonyImporter >> importArgumentFrom: argumentElement [
	| argument service |
	(argumentElement @ #type) stringValue = 'service' ifFalse: [ ^ nil ].
	argument := GtPhpSymfonyServiceArgument new.
	service := (argumentElement includesAttribute: #id) 
		ifTrue: [ self ensureServiceNamed: (argumentElement @ #id) stringValue ]
		ifFalse: [ self importServiceFrom: (argumentElement / #service) anyOne ].
	argument service: service.
	^ argument
]

{ #category : #importing }
GtPhpSymfonyImporter >> importFromXml: anXmlFile [
	| root |
	root := XMLDOMParser parse: anXmlFile contents.
	(root / #container / #services) anyOne elements do: [ :serviceElement |
		self importServiceFrom: serviceElement ].
	services do: [ :each | mooseModel add: each ]
]

{ #category : #importing }
GtPhpSymfonyImporter >> importServiceFrom: serviceElement [
	| service |
	service := self ensureServiceNamed: (serviceElement @ #id) stringValue.
	service implementationClass: 
		(mooseModel allTypes 
			detect: [ :each | each gtPhpName = (serviceElement @ #class) stringValue asSymbol ] 
			ifNone: [ nil ]).
	(serviceElement / #argument) do: [ :argumentElement |
		| argument |
		argument := self importArgumentFrom: argumentElement.
		service addArgument: argument ].
	^ service
]

{ #category : #initialization }
GtPhpSymfonyImporter >> initialize [
	services := IdentityDictionary new.
]

{ #category : #accessing }
GtPhpSymfonyImporter >> mooseModel: aModel [
	mooseModel := aModel
]
