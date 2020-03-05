Extension { #name : #MooseAbstractGroup }

{ #category : #'*Famix-CPP' }
MooseAbstractGroup >> allParameterizableStructs [
	<navigation: 'All parameterizable structs'>
	^ self allWithType: FAMIXParameterizableCPPStruct
]

{ #category : #'*Famix-CPP' }
MooseAbstractGroup >> allParameterizedStructs [
	<navigation: 'All parameterized structs'>
	^ self allWithType: FAMIXParameterizedStruct
]
