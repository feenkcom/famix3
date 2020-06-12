Extension { #name : #FAMIXMethod }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> hasPhpSymfonyExplicitSecurity [
	^ self isPhpSymfonyRouteMethod and: [
		self isAnnotatedWith: 'Security']
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> hasPhpSymfonySecurity [
	^ self hasPhpSymfonyExplicitSecurity or: [ 
		self parentType hasPhpSymfonySecurity ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> isPhpSymfonyRouteMethod [
	^ self isAnnotatedWith: 'Route'
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonyCanBeAccessedUsingMethod: anHttpMethod [
	^ self annotationInstances 
		detect: [ :each | each annotationType name = 'Method' ]
		ifFound: [ self phpSymfonyRouteMethod includesSubstring: anHttpMethod ]
		ifNone: [ ^ true ] 
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonyGrantedSecurity [
	| param params parser |
	param := '''' asPParser , '''' asPParser negate plus flatten, '''' asPParser ==> #second.
params := param , (',' asPParser trim, param ==> #second) optional ==> [:t | t first -> t second ].
parser := 'is_granted' asPParser, '(' asPParser , params, ')' asPParser ==> #third.
	^ parser parse: self phpSymfonySecurity value
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonyRouteAnnotationInstance [
	^ self annotationInstances
		detect: [ :each | each annotationType name = 'Route' ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonyRouteMethod [
	| pathAttribute |
	self assert: self isPhpSymfonyRouteMethod.
	pathAttribute := (self annotationInstances detect: [ :each | each annotationType name = 'Method' ]) attributes first.
	^ (pathAttribute value removePrefix: '"') removeSuffix: '"'
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonyRoutePath [
	| pathAttribute |
	self assert: self isPhpSymfonyRouteMethod.
	pathAttribute := self phpSymfonyRouteAnnotationInstance attributes
		detect: [ :each | (each value includesSubstring: '=') not ].
	^ self parentType phpSymfonyRoutePath , pathAttribute value
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonySecurity [
	self assert: self isPhpSymfonyRouteMethod.
	^ self hasPhpSymfonyExplicitSecurity 
		ifTrue: [ (self gtPhpAnnotationNamed: 'Security') attributes anyOne value ]
		ifFalse: [ self parentType phpSymfonySecurity ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethod >> phpSymfonySecurityRole [
	^ ((('has_role(''' asParser , '''' asParser negate star flatten)) ==> #second) 
		parse: self phpSymfonySecurity value
]
