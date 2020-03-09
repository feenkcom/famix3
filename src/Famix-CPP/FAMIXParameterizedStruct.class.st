Class {
	#name : #FAMIXParameterizedStruct,
	#superclass : #FAMIXType,
	#instVars : [
		'arguments',
		'parameterizableStruct'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXParameterizedStruct >> arguments [
	<MSEProperty: #arguments type: #FAMIXType opposite: #argumentsInParameterizedStructs> <multivalued>
	<MSEComment: 'Argument types of this parameterized type.'>
	
	^ arguments
]

{ #category : #accessing }
FAMIXParameterizedStruct >> arguments: aCollection [
	arguments value: aCollection.
	self resetMooseName
]

{ #category : #'initialize-release' }
FAMIXParameterizedStruct >> initialize [ 
	super initialize.
	arguments := FMMultiMultivalueLink on: self opposite: #argumentsInParameterizedStructs
]

{ #category : #testing }
FAMIXParameterizedStruct >> isParameterizedType [
	^ true
]

{ #category : #printing }
FAMIXParameterizedStruct >> mooseNameOn: aStream [ 
	self parameterizableStruct notNil 
		ifTrue: [self parameterizableStruct mooseNameOn: aStream].
	aStream nextPut: $<.
	self arguments 
		do: [:each | each mooseNameOn: aStream]
		separatedBy: [aStream nextPut: $,].  
	aStream nextPut: $>.  

]

{ #category : #'initialize-release' }
FAMIXParameterizedStruct >> namespaceScope [
	"we ask the namespaceScope of the parameterizable struct"
	
	^ self parameterizableStruct ifNotNil: [
		self parameterizableStruct namespaceScope ]
]

{ #category : #accessing }
FAMIXParameterizedStruct >> parameterizableStruct [
	<MSEProperty: #parameterizableStruct type: #FAMIXParameterizableCPPStruct opposite: #parameterizedTypes>
	<MSEComment: 'Base type of this parameterized type.'>
	
	^ parameterizableStruct
]

{ #category : #accessing }
FAMIXParameterizedStruct >> parameterizableStruct: aParameterizableStruct [

	parameterizableStruct := FMMultivalueLink 
		on: self
		update: #parameterizedTypes
		from: self parameterizableStruct
		to: aParameterizableStruct.
	self resetMooseName
]
