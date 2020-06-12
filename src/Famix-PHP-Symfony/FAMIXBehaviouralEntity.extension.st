Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXBehaviouralEntity >> isPhpSymfonyPostHttpMethod [
	^ self isPhpSymfonyRoute and: [ 
		(self isAnnotatedWith: 'Method') and: [ 
			(self gtPhpAnnotationNamed: 'Method') attributes first value asLowercase includesSubstring: 'post' ] ]
		
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXBehaviouralEntity >> isPhpSymfonyRoute [
	^ self isAnnotatedWith: 'Route' 
]
