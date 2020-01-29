Extension { #name : #CPPEnumSpecifierNode }

{ #category : #'*Famix-CPP' }
CPPEnumSpecifierNode >> isEnum [
	^ true
]

{ #category : #'*Famix-CPP' }
CPPEnumSpecifierNode >> simpleName [
	^ name isNil
		ifFalse: [ name source ]
]
