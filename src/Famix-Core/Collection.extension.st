Extension { #name : #Collection }

{ #category : #'*Famix-Core' }
Collection >> asFamixCollection [
	^ self
]

{ #category : #'*famix-core' }
Collection >> mooseIncludes: anObject [

	^ self includes: anObject 
]
