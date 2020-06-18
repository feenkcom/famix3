Trait {
	#name : #TGtPhpReturnStatement,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpReturnStatement >> shortDescriptionOn: aStream [
	aStream nextPutAll: 'return '.
	self expression shortDescriptionOn: aStream
]
