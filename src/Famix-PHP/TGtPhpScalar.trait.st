Trait {
	#name : #TGtPhpScalar,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpScalar >> shortDescriptionOn: aStream [
	self type ifNotNil: [ 
		aStream 
			nextPutAll: self type;
			nextPutAll: ':' ].
	aStream 
		nextPutAll: self value
]
