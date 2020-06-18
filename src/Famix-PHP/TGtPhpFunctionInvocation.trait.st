Trait {
	#name : #TGtPhpFunctionInvocation,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpFunctionInvocation >> shortDescriptionOn: aStream [
	self functionName shortDescriptionOn: aStream.
	aStream nextPutAll: '('.
	self parameters
		do: [ :aParameter | aParameter shortDescriptionOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'.
]
