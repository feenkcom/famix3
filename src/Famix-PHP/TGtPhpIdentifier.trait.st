Trait {
	#name : #TGtPhpIdentifier,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpIdentifier >> shortDescriptionOn: aStream [
	aStream
		nextPutAll: self name
]
