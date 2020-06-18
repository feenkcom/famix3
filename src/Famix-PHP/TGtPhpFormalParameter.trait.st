Trait {
	#name : #TGtPhpFormalParameter,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpFormalParameter >> shortDescriptionOn: aStream [ 
	self parameterName shortDescriptionOn: aStream
]
