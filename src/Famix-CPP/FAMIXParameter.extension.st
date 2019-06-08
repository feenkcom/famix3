Extension { #name : #FAMIXParameter }

{ #category : #'*Famix-CPP' }
FAMIXParameter >> beOptional [
	self propertyNamed: #optional put: true
]

{ #category : #'*Famix-CPP' }
FAMIXParameter >> isOptional [
	^ self propertyNamed: #optional ifNil: [ false ]
]
