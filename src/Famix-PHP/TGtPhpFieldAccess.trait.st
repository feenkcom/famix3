Trait {
	#name : #TGtPhpFieldAccess,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpFieldAccess >> shortDescriptionOn: aStream [
	self dispatcher shortDescriptionOn: aStream.
	aStream nextPutAll: '->'.
	self property shortDescriptionOn: aStream.
]
