Trait {
	#name : #TGtPhpMethodDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #accessing }
TGtPhpMethodDeclaration >> methodNameValue [
	^ self functionDeclaration functionNameValue
]

{ #category : #printing }
TGtPhpMethodDeclaration >> mooseNameOn: stream [
	super mooseNameOn: stream.
	stream 
		nextPutAll: ' (';
		nextPutAll: self methodNameValue;
		nextPutAll: ')'
]
