Trait {
	#name : #TGtPhpScalar,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpScalar >> mooseNameOn: aStream [
	super mooseNameOn: aStream.
	aStream nextPutAll: ' ('.
	self shortDescriptionOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #printing }
TGtPhpScalar >> shortDescriptionOn: aStream [
	self type ifNotNil: [ 
		aStream 
			nextPutAll: self type;
			nextPutAll: ':' ].
	aStream 
		nextPutAll: self value
]
