Trait {
	#name : #TGtPhpMethodDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #accessing }
TGtPhpMethodDeclaration >> methodNameValue [
	^ self functionDeclaration functionNameValue
]

{ #category : #printing }
TGtPhpMethodDeclaration >> shortDescriptionOn: aStream [
	aStream nextPutAll: self methodNameValue
]
