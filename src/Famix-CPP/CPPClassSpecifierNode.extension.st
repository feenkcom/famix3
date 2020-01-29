Extension { #name : #CPPClassSpecifierNode }

{ #category : #'*Famix-CPP' }
CPPClassSpecifierNode >> isCPPClass [
	^ self isStructure not and: [ self isUnion not ]
]

{ #category : #'*Famix-CPP' }
CPPClassSpecifierNode >> isStructure [
	^ structToken notNil
]

{ #category : #'*Famix-CPP' }
CPPClassSpecifierNode >> isUnion [
	^ unionToken notNil
]

{ #category : #'*Famix-CPP' }
CPPClassSpecifierNode >> simpleName [
	^ name isNil
		ifFalse: [ name source ]
]
