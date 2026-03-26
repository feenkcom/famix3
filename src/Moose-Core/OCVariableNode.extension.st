Extension { #name : #OCVariableNode }

{ #category : #'*Moose-Core' }
OCVariableNode >> isSuper [

	^ name asString = 'super'
]
