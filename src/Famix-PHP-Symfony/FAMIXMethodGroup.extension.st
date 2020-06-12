Extension { #name : #FAMIXMethodGroup }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXMethodGroup >> allPhpSymfonyRouteMethods [
	^ self select: [ :each | each isPhpSymfonyRoute  ]
]
