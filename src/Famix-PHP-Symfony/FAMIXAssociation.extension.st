Extension { #name : #FAMIXAssociation }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXAssociation >> isToPhpSymfonyController [
	^ self to asOrderedCollection notEmpty 
		and: [ self to asOrderedCollection anyOne typeScope isPhpSymfonyController and: [ 
			self to asOrderedCollection anyOne typeScope isStub not ] ] 
]
