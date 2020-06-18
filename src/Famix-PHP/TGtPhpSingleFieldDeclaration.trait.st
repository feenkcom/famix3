Trait {
	#name : #TGtPhpSingleFieldDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpSingleFieldDeclaration >> shortDescriptionOn: aStream [
	self variableName shortDescriptionOn: aStream
]
