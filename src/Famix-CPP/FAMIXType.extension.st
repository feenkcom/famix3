Extension { #name : #FAMIXType }

{ #category : #'*Famix-CPP' }
FAMIXType >> argumentsInParameterizedStructs [
	<MSEProperty: #argumentsInParameterizedStructs type: #FAMIXParameterizedStruct opposite: #arguments>
	<multivalued> <derived>
	<MSEComment: 'Arguments of parameterized types that point to this type.'>
	
	^ self privateState 
		attributeAt: #argumentsInParameterizedStructs 
		ifAbsentPut: [
			FMMultiMultivalueLink on: self opposite: #arguments ]
]
