Extension { #name : #MooseModel }

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allModelPhpSymfonyServices [
	<navigation: 'All model PHP Symfony services'>
	^ self allPhpSymfonyServices select: [:each | each implementationClass notNil and: [each implementationClass isStub not]]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyControllerClasses [
	<navigation: 'All PHP Symfony controller classes'>
	^ self allTypes select: [ :each | each isPhpSymfonyController ]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyEntityClasses [
	<navigation: 'All PHP Symfony entity classes'>
	^ self allTypes select: [ :each | each isPhpSymfonyEntity ]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyRepositoryClasses [
	<navigation: 'All PHP Symfony repository classes'>
	^ self allTypes select: [ :each | each isPhpSymfonyRepository ]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyRouteMethods [
	<navigation: 'All PHP Symfony route methods'>
	^ self allMethods ifNotEmpty: [ self allMethods allPhpSymfonyRouteMethods ]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyServiceClasses [
	<navigation: 'All PHP Symfony service classes'>
	^ (self allPhpSymfonyServices 
		collect: [ :each | each implementationClass ] 
		thenSelect: [ :each | each notNil ]) asMooseGroup
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyServices [
	<navigation: 'All PHP Symfony services'>
	^ self allWithType: GtPhpSymfonyService
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> allPhpSymfonyTaskClasses [
	<navigation: 'All PHP Symfony task classes'>
	^ self allTypes select: [ :each | each isPhpSymfonyTask ]
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> phpImportSymfonyServicesFrom: anXmlFile [
	GtPhpSymfonyImporter new 
		mooseModel: self;
		importFromXml: anXmlFile
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> serviceControllerDependenciesHighlighting2: targetClasses [
	| modelServices servicesDictionary allServicesClasses controllerClasses servicesPerController servicesFromControllers servicesFromServices targetClientTypes view| 
	modelServices := (self "mooseModel" allPhpSymfonyServices) reject: [ :aService | 
		aService implementationClass isNil or: [ aService implementationClass isStub] ].

	servicesDictionary := Dictionary new.
	modelServices do: [ :aService |
		servicesDictionary at: aService name put: aService ].
	allServicesClasses := (modelServices collect: #implementationClass) asSet reject: #isNil.

	controllerClasses := (self "mooseModel" allModelClasses select: [ :each | 
		(each superclass name = 'BaseApiController') or: [ 
			each superclass name = 'BaseAdminController' ] ]) asSet.

	servicesPerController := Dictionary new.
	controllerClasses do: [ :aClass | 
		servicesPerController at: aClass put: (((aClass phpAstStrings 
			select: [ :aScalar | 
				servicesDictionary includesKey: aScalar pharoValue ]))
			collect: [ :aScalar |
				(servicesDictionary at: aScalar pharoValue) implementationClass ]) ].
		
	servicesFromControllers := (servicesPerController values flatCollect: #yourself) asSet.
	servicesFromServices := ((servicesFromControllers flatCollect: #providerTypes) reject: #isStub) intersection: allServicesClasses.

	targetClientTypes := targetClasses collect: #clientTypes.

	view := RTMondrian new.
	view shape label
		text: [ :class | class name ];
	"b shape circle
		size: 30;"
		"if: [ :anEntity | controllerClasses includes: anEntity ] color: Color red;"
		if: [ :anEntity |	
			targetClientTypes allSatisfy: [ :clientTypesList |
				clientTypesList includes: anEntity  ] ] color: Color blue.
	view nodes: controllerClasses, servicesFromServices, servicesFromControllers.
	view shape arrowedLine
		color: (Color black alpha: 0.1);
		withShorterDistanceAttachPoint.
	view edges connectToAll: [ :anEntity |
		anEntity providerTypes,
		(servicesPerController at: anEntity ifPresent: [:services | services ] ifAbsent: [ #() ]) ].
	view layout horizontalDominanceTree
		leftGap: 20;
		topGap: 20;
		horizontalGap: 50;
		layered.
	view build.
	view view pushBackEdges.
	^ view
]

{ #category : #'*Famix-PHP-Symfony' }
MooseModel >> serviceControllerDependenciesHighlighting: aCollectionOfClasses [
	| modelServices servicesDictionary allServicesClasses controllerClasses servicesPerController servicesFromControllers servicesFromServices view| 
	modelServices := (self allPhpSymfonyServices) reject: [ :aService | 
		aService implementationClass isNil or: [ aService implementationClass isStub] ].

	servicesDictionary := Dictionary new.
	modelServices do: [ :aService |
		servicesDictionary at: aService name put: aService ].
	allServicesClasses := (modelServices collect: #implementationClass) asSet reject: #isNil.

	controllerClasses := self allModelClasses select: #isPhpSymfonyController.

	servicesPerController := Dictionary new.
	controllerClasses do: [ :aClass | 
		servicesPerController at: aClass put: (((aClass phpAstStrings 
			select: [ :aScalar | 
				servicesDictionary includesKey: aScalar pharoValue ]))
			collect: [ :aScalar |
				(servicesDictionary at: aScalar pharoValue) implementationClass ]) ].
		
	servicesFromControllers := (servicesPerController values flatCollect: #yourself) asSet.
	servicesFromServices := ((servicesFromControllers flatCollect: #providerTypes) reject: #isStub) intersection: allServicesClasses.

	view := RTMondrian new.
	view shape label
		color: Color black;
		text: [ :class | class name ];
	"b shape circle
		size: 30;"
		"if: [ :anEntity | controllerClasses includes: anEntity ] color: Color red;"
		if: [ :anEntity |	aCollectionOfClasses includes: anEntity ] color: Color blue.
	view nodes: controllerClasses, servicesFromServices, servicesFromControllers.
	view shape arrowedLine
		color: (Color black alpha: 0.1);
		withShorterDistanceAttachPoint.
	view edges connectToAll: [ :anEntity |
		anEntity providerTypes,
		(servicesPerController at: anEntity ifPresent: [:services | services ] ifAbsent: [ #() ]) ].
	view layout horizontalDominanceTree
		leftGap: 20;
		topGap: 20;
		horizontalGap: 50;
		layered.
	view build.
	view view pushBackEdges.
	^ view
]
