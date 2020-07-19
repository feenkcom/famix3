Extension { #name : #RBVariableNode }

{ #category : #'*Moose-Core' }
RBVariableNode >> isSuper [

	^ name asString = 'super'
]
