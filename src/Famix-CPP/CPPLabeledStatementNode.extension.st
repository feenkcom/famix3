Extension { #name : #CPPLabeledStatementNode }

{ #category : #'*Famix-CPP' }
CPPLabeledStatementNode >> isEmitStatement [
	^ self label source = 'emit'
]
