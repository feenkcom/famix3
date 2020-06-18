Trait {
	#name : #TGtPhpFunctionDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #accessing }
TGtPhpFunctionDeclaration >> functionNameValue [
	^ self functionName name
]

{ #category : #accessing }
TGtPhpFunctionDeclaration >> shortDescriptionOn: aStream [
	aStream nextPutAll: self functionNameValue
]
