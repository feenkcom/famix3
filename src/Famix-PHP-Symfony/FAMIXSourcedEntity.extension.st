Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXSourcedEntity >> phpAstStringSymfonyServiceReferences [
	| referencesToServices |
	referencesToServices := OrderedCollection new.
	self phpAstStrings do: [ :each | 
		self mooseModel allPhpSymfonyServices 
			detect: [ :service | service name = each pharoValue ]
			ifFound: [ :service | referencesToServices add: service ] ].
	^ referencesToServices
]
