Trait {
	#name : #TGtPhpMethodDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #accessing }
TGtPhpMethodDeclaration >> methodNameValue [
	^ self functionDeclaration functionNameValue
]
