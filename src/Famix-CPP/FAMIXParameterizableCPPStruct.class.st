Class {
	#name : #FAMIXParameterizableCPPStruct,
	#superclass : #FAMIXCPPStruct,
	#instVars : [
		'parameterizedTypes'
	],
	#category : #'Famix-CPP'
}

{ #category : #'initialize-release' }
FAMIXParameterizableCPPStruct >> initialize [
	super initialize.
	parameterizedTypes := FMMultivalueLink 
		on: self
		opposite: #parameterizableStruct:
]

{ #category : #accessing }
FAMIXParameterizableCPPStruct >> parameterizedTypes [
	<MSEProperty: #parameterizedTypes type: #FAMIXParameterizedStruct opposite: #parameterizableStruct>
	<multivalued> <derived>
	^ parameterizedTypes
]

{ #category : #accessing }
FAMIXParameterizableCPPStruct >> parameterizedTypes: aCollection [
	parameterizedTypes value: aCollection
]

{ #category : #generated }
FAMIXParameterizableCPPStruct >> parameters [
	<MSEProperty: #parameters type: #FAMIXParameterType> <multivalued> <derived>
	<MSEComment: 'Parameter types of this class.'>
	
	^self types select: [:each | each isParameterType]
]

{ #category : #generated }
FAMIXParameterizableCPPStruct >> parameters: aCollection [

	self privateState attributeAt: #parameters put: aCollection
]
