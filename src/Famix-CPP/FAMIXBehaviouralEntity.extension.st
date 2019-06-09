Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Famix-CPP' }
FAMIXBehaviouralEntity >> beVariadic [
	self propertyNamed: #variadic put: true
]

{ #category : #'*Famix-CPP' }
FAMIXBehaviouralEntity >> isVariadic [
	^ self propertyNamed: #variadic ifNil: [ false ]
]

{ #category : #'*Famix-CPP' }
FAMIXBehaviouralEntity >> minimumArgumentCount [
	^ self parameters
		inject: 0
		into: [ :sum :each | 
			sum
				+
					(each isOptional
						ifTrue: [ 0 ]
						ifFalse: [ 1 ]) ]
]
