Extension { #name : #FAMIXNamespace }

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> abstractness [
	"Abstractness is the ratio between the number of abstract classes and the total number of classes in a package, in the range [0, 1]. 0 means the package is fully concrete, 1 it is fully abstract."
	<MSEProperty: #abstractness type: #Number>
	<derived>
	<MSEComment: 'Abstractness of a namespace'>

	| nsClasses |
	nsClasses := self allClasses select: [:c | c isInstanceSide].
	(nsClasses size == 0) ifTrue: [^nil].
	
	^ (nsClasses select: [:c | c isAbstract]) size / (nsClasses size) asFloat
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> abstractness: aNumber [

	self privateState propertyAt: #abstractness put: aNumber
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> accept: aVisitor [

	aVisitor visitNamespace: self
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> afferentCoupling [
	<MSEProperty: #afferentCoupling type: #Number>
	<derived>
	<MSEComment: 'Afferent Coupling of a namespace Afferent is the number of classes that depend upon this namespace'>
	^ ((self queryAllIncoming atScope: FAMIXType) outOfMyNamespace select: [ :c | c isInstanceSide ]) size
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> afferentCoupling: aNumber [

	self privateState propertyAt: #afferentCoupling put: aNumber
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> allParentsUpTo: aNamespace [
	(self parentScope isNil or: [self parentScope = aNamespace ]) ifTrue: [ ^ OrderedCollection new ].
	^ self parentScope withAllParentsUpTo: aNamespace
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> bunchCohesion [
	"Computing cohesion (Bunch formula)"

	<MSEProperty: #bunchCohesion type: #Number>
	<derived>
	<MSEComment: 'Bunch Cohesion of a namespace. It is also considered anonymous and inner classes.'>
	| myClasses intraConnectivities |
	(myClasses := self classes) union: (myClasses flatCollect: [ :c | c allRecursiveTypes ]).
	myClasses size == 0
		ifTrue: [ ^ nil ].
	intraConnectivities := (myClasses collect: [ :c | (c queryOutgoingDependencies atScope: FAMIXType) withinMyNamespace ]) inject: 0 into: [ :subTotal :each | subTotal + each size ].
	^ intraConnectivities / myClasses size squared asFloat
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> bunchCohesion: aNumber [

	self privateState propertyAt: #bunchCohesion put: aNumber
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> bunchCouplingWith: aNamespace [
	"Computing coupling (Bunch formula) between receiver and aNamespace"

	| myClasses otherClasses interConnectivities |
	myClasses := self classes.
	myClasses := myClasses union: (myClasses flatCollect: [ :c | c allRecursiveTypes ]).
	otherClasses := aNamespace classes.
	otherClasses := otherClasses union: (otherClasses flatCollect: [ :c | c allRecursiveTypes ]).
	(myClasses size == 0 or: [ otherClasses size == 0 ])
		ifTrue: [ ^ nil ].

	"All outgoing dependencies"
	interConnectivities := (myClasses collect: [ :c | (c queryOutgoingDependencies atScope: FAMIXType) withinNamespace: aNamespace ]) inject: 0 into: [ :subTotal :each | subTotal + each size ].

	"Plus all incoming dependencies"
	interConnectivities := interConnectivities
		+ ((myClasses collect: [ :c | (c queryIncomingDependencies atScope: FAMIXType) withinNamespace: aNamespace ]) inject: 0 into: [ :subTotal :each | subTotal + each size ]).
	^ interConnectivities / (2 * myClasses size * otherClasses size) asFloat
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> bunchCouplingWithAll [
	"Computing coupling (Bunch formula) between receiver and all namespaces"

	| myClasses interConnectivities allClasses |
	myClasses := self classes.
	myClasses := myClasses union: (myClasses flatCollect: [ :c | c allRecursiveTypes ]).
	allClasses := self mooseModel allModelNamespaces flatCollect: [ :aNamespace | aNamespace classes ].
	allClasses := allClasses union: (allClasses flatCollect: [ :aClass | aClass allRecursiveTypes ]).
	(myClasses isEmpty or: [ allClasses isEmpty ])
		ifTrue: [ ^ nil ].

	"All outgoing dependencies"
	interConnectivities := (myClasses collect: [ :c | (c queryOutgoingDependencies atScope: FAMIXType) outOfMyNamespace ])
		inject: 0
		into: [ :subTotal :each | subTotal + (each select: [ :c | c isInstanceSide ]) size ].

	"Plus all incoming dependencies"
	interConnectivities := interConnectivities
		+ ((myClasses collect: [ :c | (c queryIncomingDependencies atScope: FAMIXType) outOfMyNamespace ]) inject: 0 into: [ :subTotal :each | subTotal + (each select: [ :c | c isInstanceSide ]) size ]).
	^ interConnectivities / (2 * myClasses size * (allClasses size - myClasses size)) asFloat
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> childrenOfMyKind [
	^ self childScopes
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> clientClasses [
	self deprecated: 'use clientTypes'.
	^ self clientTypes
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> clientNamespaces [
	"MooseCook was: ^ self inheritedByNamespaces union: self invokingNamespaces"

	^ (self queryAllIncoming atScope: FAMIXNamespace) withoutSelfLoops
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> clientTypes [
	<MSEProperty: #clientTypes type: #FAMIXType>
	<multivalued>
	<derived>
	<MSEComment: 'All types that depend on the receiver'>
	^ (self queryAllIncoming atScope: FAMIXType) withoutSelfLoops
]

{ #category : #'*famix-extensions-accessing' }
FAMIXNamespace >> containedEntities [
	^self types
]

{ #category : #'*famix-extensions-accessing' }
FAMIXNamespace >> containedEntities: collection [
	self types: collection.
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> distance [
	"D = A + I - 1. A package should be balanced between abstractness and instability, i.e., somewhere between abstract and stable or concrete and unstable. This rule defines the main sequence by the equation A + I - 1 = 0. D is the distance to the main sequence."
	<MSEProperty: #distance type: #Number>
	<derived>
	<MSEComment: 'Distance of a namespace'>

	| abstractness instability |
	abstractness := self abstractness.
	instability := self instability.
	
	(abstractness isNil or: [instability isNil]) ifTrue: [^ nil].
	^ abstractness + instability - 1
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> distance: aNumber [

	self privateState propertyAt: #distance put: aNumber
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> efferentCoupling [
	"Efferent coupling for a module is the number of classes it depends upon"

	<MSEProperty: #efferentCoupling type: #Number>
	<derived>
	<MSEComment:
		'Efferent coupling for a module is the number of classes it depends upon'>
	^ ((self queryOutgoingDependencies outOfMyNamespace
		atScope: FAMIXType) select: [ :c | c isInstanceSide ]) size
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> efferentCoupling: aNumber [

	self privateState propertyAt: #efferentCoupling put: aNumber
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> instability [
	"I =	Ce(P)/(Ce(P)+Ca(P)), in the range [0, 1]. 0 means package is maximally stable (i.e., no dependency to other packages and can not change without big consequences), 1 means it is unstable."
	<MSEProperty: #instability type: #Number>
	<derived>
	<MSEComment: 'Instability of a namespace'>
	
	| efferentCoupling afferentCoupling |
	
	efferentCoupling := self efferentCoupling.
	afferentCoupling := self afferentCoupling.
	(efferentCoupling + afferentCoupling) == 0 ifTrue: [^ nil].
	^ efferentCoupling / (efferentCoupling + afferentCoupling) asFloat
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> instability: aNumber [

	self privateState propertyAt: #instability put: aNumber
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> martinCohesion [
	"Computing cohesion as described by Robert C. Martin"

	<MSEProperty: #martinCohesion type: #Number>
	<derived>
	<MSEComment: 'Cohesion as defined by Robert C. Martin.'>
	| intraConnectivities myClasses |
	myClasses := self classes.
	myClasses := (myClasses union: (myClasses flatCollect: [ :c | c allRecursiveTypes ])) select: [ :c | c isInstanceSide ].
	myClasses size == 0
		ifTrue: [ ^ nil ].
	intraConnectivities := (myClasses collect: [ :c | (c queryOutgoingDependencies atScope: FAMIXType) withoutSelfLoops withinMyNamespace ])
		inject: 0
		into: [ :subTotal :each | subTotal + (each select: [ :c | c isInstanceSide ]) size ].
	^ ((intraConnectivities + 1) / myClasses size) asFloat
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfAttributes [
"	<property: #NOA longName: 'Number of attributes' description:
			'The number of attributes in a namespace'>"

	<MSEProperty: #numberOfAttributes type: #Number>
	<derived>
	<MSEComment: 'The number of attributes in a namespace'>
	
	^ self
		lookUpPropertyNamed: #numberOfAttributes
		computedAs: [self types inject: 0 into: [ :sum :each | sum + each numberOfAttributes] ]
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfAttributes: aNumber [

	self privateState propertyAt: #numberOfAttributes put: aNumber
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfClasses [
	<MSEProperty: #numberOfClasses type: #Number>
	<derived>
	<MSEComment: 'The number of classes in a namespace'>
	
	^self
		lookUpPropertyNamed: #numberOfClasses
		computedAs: [self types size]
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfClasses: aNumber [

	self privateState propertyAt: #numberOfClasses put: aNumber
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfLinesOfCode [
	<MSEProperty: #numberOfLinesOfCode type: #Number>
	<derived>
	<MSEComment: 'The number of lines of code in a namespace'>
	
	^self
		lookUpPropertyNamed: #numberOfLinesOfCode
		computedAs: [
			self functions inject: (self types inject: 0 into: [ :sum :each | sum + each numberOfLinesOfCode])
				into: [ :sum :each | sum + each numberOfLinesOfCode]]
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfLinesOfCode: aNumber [

	self privateState propertyAt: #numberOfLinesOfCode put: aNumber
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfMethods [
	<MSEProperty: #numberOfMethods type: #Number>
	<derived>
	<MSEComment: 'The number of methods in a namespace'>
	
	^self
		lookUpPropertyNamed: #numberOfMethods
		computedAs: [self types inject: 0 into: [ :sum :each | sum + each numberOfMethods ]]
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> numberOfMethods: aNumber [

	self privateState propertyAt: #numberOfMethods put: aNumber
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> numberOfNonInterfacesClasses [
	<MSEProperty: #numberOfNonInterfacesClasses type: #Number>
	<derived>
	<MSEComment: 'The number of non interfaces classes in a namespace'>
	
	^self
		lookUpPropertyNamed: #numberOfNonInterfacesClasses
		computedAs: [(self types reject: #isInterface) size]
]

{ #category : #'*famix-extensions-metrics' }
FAMIXNamespace >> numberOfNonInterfacesClasses: aNumber [

	self privateState propertyAt: #numberOfNonInterfacesClasses put: aNumber
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> providerClasses [
	self deprecated: 'use providerTypes'.
	^ self providerTypes
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> providerNamespaces [
	"MooseCook was: ^ self inheritedNamespaces union: self invokedNamespaces"

	^ (self queryAllOutgoing atScope: FAMIXNamespace) withoutSelfLoops
]

{ #category : #'*famix-extensions-nav All Dependencies' }
FAMIXNamespace >> providerTypes [
	<MSEProperty: #providerTypes type: #FAMIXType>
	<derived>
	<multivalued>
	<MSEComment: 'All types that the receiver depends on'>
	^ (self queryAllOutgoing atScope: FAMIXType) withoutSelfLoops
]

{ #category : #'*Famix-Extensions' }
FAMIXNamespace >> withAllParentsUpTo: aNamespace [
	^ (self parentScope allParentsUpTo: aNamespace) addFirst: self; yourself
]
