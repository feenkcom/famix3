Extension { #name : #CPPBinaryExpressionNode }

{ #category : #'*Famix-CPP' }
CPPBinaryExpressionNode >> additionalCyclomaticComplexityEdges [
	^ (#('||' '&&') includes: operator value)
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]
