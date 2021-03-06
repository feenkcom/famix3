"
FAMIXMethodGroup is a MooseGroup containing only FAMIX enities of type FAMIXMethod.
"
Class {
	#name : #FAMIXMethodGroup,
	#superclass : #FAMIXBehaviouralEntityGroup,
	#category : #'Famix-Extensions'
}

{ #category : #meta }
FAMIXMethodGroup class >> annotation [
	<MSEClass: #MethodGroup super: #FAMIXBehaviouralEntityGroup>
	<package: #FAMIX>

]

{ #category : #navigation }
FAMIXMethodGroup >> allClasses [

	^ FAMIXTypeGroup withAll: (self entities collectAsSet: [:m | m parentType])
]

{ #category : #navigation }
FAMIXMethodGroup >> allMethods [

	^ self
]

{ #category : #navigation }
FAMIXMethodGroup >> allPackages [

	^ FAMIXPackageGroup withAll: ((self entities collectAsSet: [:m | m packageScope]) reject: #isNil)
]

{ #category : #metrics }
FAMIXMethodGroup >> averageNumberOfInvocations [
	<MSEProperty: #averageNumberOfInvocations type: #Number>
	<MSEComment: 'Average number of invocations per methods'>

	^self
		lookUpPropertyNamed: #averageNumberOfInvocations
		computedAs: [self average: [:each | each numberOfOutgoingInvocations ]]
]

{ #category : #metrics }
FAMIXMethodGroup >> averageNumberOfLinesOfCode [
	<MSEProperty: #averageNumberOfLinesOfCode type: #Number>
	<MSEComment: 'Average number of lines of code per methods'>

	^self
		lookUpPropertyNamed: #averageNumberOfLinesOfCode
		computedAs: [self average: [:each | each numberOfLinesOfCode ]]
]

{ #category : #metrics }
FAMIXMethodGroup >> averageNumberOfParameters [
	<MSEProperty: #averageNumberOfParameters type: #Number>
	<MSEComment: 'Average number of parameters per methods'>
	
	^self
		lookUpPropertyNamed: #averageNumberOfParameters
		computedAs: [self average: [:each | each numberOfParameters]]
]
