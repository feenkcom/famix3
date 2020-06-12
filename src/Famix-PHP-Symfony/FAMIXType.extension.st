Extension { #name : #FAMIXType }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> hasPhpSymfonySecurity [
	^ self isAnnotatedWith: 'Security'
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyCommand [
	^ self withSuperclassHierarchy anySatisfy: [ :each |
		each mooseName = #'Symfony::Bundle::FrameworkBundle::Command::ContainerAwareCommand' ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyController [
	^ self withSuperclassHierarchy anySatisfy: [ :each |
		each mooseName = #'Symfony::Bundle::FrameworkBundle::Controller::Controller' ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyDoctrineEntityRepository [
	^ self mooseName = #'Doctrine::ORM::EntityRepository'
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyEntity [
	^ self isAnnotatedWith: 'Entity'
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyRepository [
	^ self superclassHierarchy anySatisfy: [ :each | each isPhpSymfonyDoctrineEntityRepository ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyService [
	self privateState attributeAt: #phpSymfonyService ifAbsent: [^ false].
	^ true
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> isPhpSymfonyTask [
	^ self superclassHierarchy anySatisfy: [ :each |
		each mooseName = #'TaskBundle::Task::Executor' ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> phpSymfonyRoutePath [
	| pathAttribute |
	(self isAnnotatedWith: 'Route') ifFalse: [ ^'' ].
	pathAttribute := (self annotationInstances detect: [ :each | each annotationType name = 'Route' ]) attributes 
		detect: [:each | (each value includesSubstring: '=') not].
	^ pathAttribute value
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> phpSymfonySecurity [
	^ (self isAnnotatedWith: 'Security') 
		ifTrue: [ (self gtPhpAnnotationNamed: 'Security') attributes anyOne value ]
		ifFalse: [ nil ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> phpSymfonyService [
	^ self privateState attributeAt: #phpSymfonyService
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXType >> phpSymfonyService: aService [
	self privateState attributeAt: #phpSymfonyService put: aService
]
