Trait {
	#name : #TGtPhpMethodInvocation,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpMethodInvocation >> shortDescriptionOn: aStream [
	self dispatcher shortDescriptionOn: aStream.
	aStream nextPutAll: '->'.
	self property shortDescriptionOn: aStream.
]
