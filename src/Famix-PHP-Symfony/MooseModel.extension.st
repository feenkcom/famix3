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
