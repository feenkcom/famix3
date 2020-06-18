Trait {
	#name : #TGtPhpNamespaceName,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpNamespaceName >> shortDescriptionOn: aStream [
	(self global = 'true') ifTrue: [ 
		aStream nextPutAll: '/'	].
	self segments do: [ :each | 
		each shortDescriptionOn: aStream ]
]
