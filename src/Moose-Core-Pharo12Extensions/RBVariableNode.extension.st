Extension { #name : #RBVariableNode }

{ #category : #'*Moose-Core-Pharo12Extensions' }
RBVariableNode >> isSuper [

	^ name asString = 'super'
]
