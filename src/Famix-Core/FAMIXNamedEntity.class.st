"
FAMIXNamedEntity is an abstract class, root of the hierarchy modeling source code entities. FAMIXNamedEntity has a name and it is physically present in source code. For example, methods, variables, types, namespaces. The name of the entity only contains the basic name and not the ""fully qualified name"". Apart from the name, it also has modifiers (e.g. public, protected, final, etc.) and it can be marked as a stub. A stub is a FAMIXNamedEntity that is used in the source code but its source is not available. 

When applicable, a FAMIXNamedEntity also points to its containing package accessible via parentPackage.

Any of its subclasses must define the meaning of the belongsTo property, an abstract property that provides polymorphic traversal. For example,  FAMIXClass defines belongsTo as being the container, while the FAMIXMethod defines belongsTo to point to the parentType. belongsTo can be used to calculate the ""full qualified name"" of a named entity. belongsTo is a derived property, which means that it is always computed from the information of other properties.

It can also return the list of invocations performed on this entity (considered as the receiver) (receivingInvocations). 
"
Class {
	#name : #FAMIXNamedEntity,
	#superclass : #FAMIXSourcedEntity,
	#traits : 'TDependencyQueries + TEntityMetaLevelDependency',
	#classTraits : 'TDependencyQueries classTrait + TEntityMetaLevelDependency classTrait',
	#instVars : [
		'name',
		'isStub',
		'receivingInvocations',
		'modifiers',
		'parentPackage',
		'annotationInstances'
	],
	#classInstVars : [
		'childrenSelectors',
		'allParentTypes',
		'allChildrenTypes',
		'parentSelectors',
		'outgoingMSEProperties',
		'incomingMSEProperties',
		'outgoingAssociationTypes',
		'incomingAssociationTypes',
		'allIncomingAssociationTypes',
		'allOutgoingAssociationTypes'
	],
	#category : #'Famix-Core'
}

{ #category : #accessing }
FAMIXNamedEntity class >> allIncomingAssociationTypes [
	"Here we add a cache because this is heavely used in MooseQuery for the navigations."

	^ allIncomingAssociationTypes
		ifNil: [ allIncomingAssociationTypes := self privateAllIncomingAssociationTypes ]
]

{ #category : #accessing }
FAMIXNamedEntity class >> allOutgoingAssociationTypes [
	"Here we add a cache because this is heavely used in MooseQuery for the navigations."

	^ allOutgoingAssociationTypes
		ifNil: [ allOutgoingAssociationTypes := self privateAllOutgoingAssociationTypes ]
]

{ #category : #meta }
FAMIXNamedEntity class >> annotation [
	<MSEClass: #NamedEntity super: #FAMIXSourcedEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
FAMIXNamedEntity class >> incomingAssociationTypes [
	"Here we add a cache because this is heavely used in MooseQuery for the navigations."

	^ incomingAssociationTypes
		ifNil: [ incomingAssociationTypes := self privateIncomingAssociationTypes ]
]

{ #category : #accessing }
FAMIXNamedEntity class >> incomingMSEProperties [
	^ incomingMSEProperties ifNil: [ incomingMSEProperties := self privateIncomingMSEProperties ]
]

{ #category : #accessing }
FAMIXNamedEntity class >> incomingMSEPropertiesCache: aValue [
	incomingMSEProperties := aValue
]

{ #category : #'instance creation' }
FAMIXNamedEntity class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #accessing }
FAMIXNamedEntity class >> outgoingAssociationTypes [
	"Here we add a cache because this is heavely used in MooseQuery for the navigations."

	^ outgoingAssociationTypes
		ifNil: [ outgoingAssociationTypes := self privateOutgoingAssociationTypes ]
]

{ #category : #accessing }
FAMIXNamedEntity class >> outgoingMSEProperties [
	^ outgoingMSEProperties ifNil: [ outgoingMSEProperties := self privateOutgoingMSEProperties ]
]

{ #category : #accessing }
FAMIXNamedEntity class >> outgoingMSEPropertiesCache: aValue [
	outgoingMSEProperties := aValue.
]

{ #category : #accessing }
FAMIXNamedEntity class >> parentMetaclass [
	^((self class >> #annotation) pragmas select: [ :p | p keyword = 'parentMetaClass:' ]) collect: [:p | p arguments first ]
]

{ #category : #accessing }
FAMIXNamedEntity >> annotationInstances [
	<MSEProperty: #annotationInstances type: #FAMIXAnnotationInstance opposite: #annotatedEntity> <multivalued> <derived>
	<MSEComment: 'This property corresponds to the set of annotations associated to the entity'>
	^ annotationInstances
]

{ #category : #accessing }
FAMIXNamedEntity >> annotationTypes [
	^ self annotationInstances collectAsSet: [:each | each annotationType ]
]

{ #category : #accessing }
FAMIXNamedEntity >> belongsTo [
	
	^self subclassResponsibility
]

{ #category : #accessing }
FAMIXNamedEntity >> children [
	| res |
	res := OrderedCollection new.
	self childrenSelectors do: [ :accessor | (self perform: accessor) ifNotNil: [ :r | res addAll: r asFamixCollection ] ].
	^ res asSet
]

{ #category : #testing }
FAMIXNamedEntity >> hasUniqueMooseNameInModel [
	" all subclasses should call the method: 'resetMooseName' if a change causes the moosename to change "
	^true
]

{ #category : #'moosequery-queries-incoming' }
FAMIXNamedEntity >> incomingTypeDeclarations [
	"Should return the incoming type declarations of the entity as MooseQueryTypeDeclarationAssociation.
	
	typeDeclaration is a virtual association that relates a structural entity (i.e. a variable) to its type."

	"Most of the time it will return nothing. Overide me if it need to return something"

	^ {}
]

{ #category : #initialization }
FAMIXNamedEntity >> initialize [
	super initialize.
	isStub := false.
	receivingInvocations := FMNullMultivalueLink on: self opposite: #receiver: selector: #receivingInvocations.
	modifiers := Set new.
	annotationInstances := FMNullMultivalueLink on: self opposite: #annotatedEntity: selector: #annotationInstances
]

{ #category : #accessing }
FAMIXNamedEntity >> isStub [
	"Flag true if the entity attributes are incomplete, either because the entity is missing or not imported."
	<MSEProperty: #isStub type: #Boolean>
	<MSEComment: 'Flag true if the entity attributes are incomplete, either because the entity is missing or not imported.'>

	^isStub
]

{ #category : #accessing }
FAMIXNamedEntity >> isStub: aBoolean [
	isStub := aBoolean
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> methodScope [
	"Empty default scope"
	^ nil
]

{ #category : #accessing }
FAMIXNamedEntity >> modifiers [
	<MSEProperty: #modifiers type: #String> <multivalued>
	<MSEComment: 'Generic container for language dependent modifiers.'>
	
	^modifiers
]

{ #category : #accessing }
FAMIXNamedEntity >> modifiers: aSet [
	modifiers := aSet
]

{ #category : #accessing }
FAMIXNamedEntity >> name [
	<MSEProperty: #name type: #String>
	<MSEComment: 'Basic name of the entity, not full reference.'>
	
	^name
]

{ #category : #accessing }
FAMIXNamedEntity >> name: aString [
	name := aString.
	self resetMooseName
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> namespaceScope [
	"Empty default scope"
	^ nil
]

{ #category : #'moosequery-queries-outgoing' }
FAMIXNamedEntity >> outgoingTypeDeclarations [
	"Should return the incoming type declarations of the entity as MooseQueryTypeDeclarationAssociation.
	
	typeDeclaration is a virtual association that relates a structural entity (i.e. a variable) to its type."

	"Most of the time it will return nothing. Overide me if it need to return something"

	^ {}
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> packageScope [
	"Empty default scope"
	^ nil
]

{ #category : #accessing }
FAMIXNamedEntity >> parentPackage [
	"Package containing the entity in the code structure (if applicable)"

	<MSEProperty: #parentPackage type: #FAMIXPackage opposite: #childNamedEntities>
	<MSEComment: 'Package containing the entity in the code structure (if applicable)'>
	<container>

	^ parentPackage
]

{ #category : #accessing }
FAMIXNamedEntity >> parentPackage: aPackage [
	parentPackage := FMMultivalueLink on: self
					update: #childNamedEntities
					from: self parentPackage
					to: aPackage
]

{ #category : #accessing }
FAMIXNamedEntity >> parents [
	| res |
	res := OrderedCollection new.
	self parentSelectors do: [ :accessor | (self perform: accessor) ifNotNil: [ :r | res addAll: r asFamixCollection ] ].
	^ res asSet
]

{ #category : #'moosequery-queries-incoming' }
FAMIXNamedEntity >> queryIncomingTypeDeclarationsIn: aCollection [
	"This method could be more readable but it needs to be really performant"

	| selectors |
	1 to: (selectors := self childrenSelectors) size do: [ :index | 
		(self perform: (selectors at: index))
			ifNotNil: [ :children | 
				| coll |
				1 to: (coll := children asFamixCollection) size do: [ :i | (coll at: i) queryIncomingTypeDeclarationsIn: aCollection ] ] ].
	aCollection addAll: self incomingTypeDeclarations.
	^ aCollection
]

{ #category : #'moosequery-queries-outgoing' }
FAMIXNamedEntity >> queryOutgoingTypeDeclarationsIn: aCollection [
	"This method could be more readable but it needs to be really performant"

	| selectors |
	1 to: (selectors := self childrenSelectors) size do: [ :index | 
		(self perform: (selectors at: index))
			ifNotNil: [ :children | 
				| coll |
				1 to: (coll := children asFamixCollection) size do: [ :i | (coll at: i) queryOutgoingTypeDeclarationsIn: aCollection ] ] ].
	aCollection addAll: self outgoingTypeDeclarations.
	^ aCollection
]

{ #category : #accessing }
FAMIXNamedEntity >> receivingInvocations [
	"Returns the list of invocations performed on this entity (considered as the receiver)"
	<MSEProperty: #receivingInvocations type: #FAMIXInvocation opposite: #receiver> <multivalued> <derived>
	<MSEComment: 'List of invocations performed on this entity (considered as the receiver)'>
	
	^receivingInvocations
]

{ #category : #accessing }
FAMIXNamedEntity >> receivingInvocations: anInvocation [
	receivingInvocations value: anInvocation
]

{ #category : #'meta information' }
FAMIXNamedEntity >> resetMooseName [
	super resetMooseName.
	self children do: [ :entity | entity resetMooseName ]
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> selectWithinYourScope: aMooseQueryResult [
	self subclassResponsibility
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> typeScope [
	"Empty default scope"
	^ nil
]

{ #category : #'moosequery-scoping-filtering' }
FAMIXNamedEntity >> yourScope [
	"Empty default scope"

	self
		deprecated:
			'#yourScope was used by MooseChef for queries. Now, MooseQuery does not need it anymore. Example of code update: "myEntity queryAllIncoming perform: mySecondEntity yourScope" => "myEntity queryAllIncoming withScope: mySecondEntity class"'
		on: '12 january 2018'
		in: 'Moose6.1'.
	^ nil
]
