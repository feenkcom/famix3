Class {
	#name : #FAMIXCPPMethod,
	#superclass : #FAMIXMethod,
	#instVars : [
		'declaration',
		'implementation'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXCPPMethod >> declaration [
	<MSEProperty: #declaration type: #FAMIXCPPMethodDeclaration opposite: #method>
	^ declaration
]

{ #category : #accessing }
FAMIXCPPMethod >> declaration: aCPPMethodDeclaration [
	declaration notNil
		ifTrue: [ declaration method: nil ].
	declaration := aCPPMethodDeclaration.
	declaration notNil
		ifTrue: [ declaration method: self ]
]

{ #category : #accessing }
FAMIXCPPMethod >> hasEmptyBody [
	^ self accesses isEmpty and: [
		self outgoingInvocations isEmpty and: [ 
			self gtASTNode children size = 1 ]]
]

{ #category : #accessing }
FAMIXCPPMethod >> implementation [
	<MSEProperty: #implementation type: #FAMIXCPPMethodImplementation
	opposite: #method>
	^ implementation
]

{ #category : #accessing }
FAMIXCPPMethod >> implementation: aCPPMethodImplementation [
	implementation notNil
		ifTrue: [ implementation method: nil ].
	implementation := aCPPMethodImplementation.
	implementation notNil
		ifTrue: [ implementation method: self ]
]

{ #category : #accessing }
FAMIXCPPMethod >> isCopyConstructor [
	^ self isConstructor and: [ self parameters size = 1 and: [self parameters anyOne declaredType = self parentType ]]
]

{ #category : #accessing }
FAMIXCPPMethod >> isDestructor [
	^ self name = ('~', self parentType name)
]

{ #category : #accessing }
FAMIXCPPMethod >> isEqualityOperator [
	^ self name = 'operator='
]

{ #category : #'as yet unclassified' }
FAMIXCPPMethod >> lambdas [
	<MSEProperty: #lambdas type: #FAMIXCPPLambda opposite: #outerMethod>
	<multivalued>
	<derived>
	^ self privateState
		attributeAt: #lambdas
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #outerMethod: ]
]

{ #category : #'as yet unclassified' }
FAMIXCPPMethod >> lambdas: aCollection [
	self lambdas value: aCollection
]

{ #category : #accessing }
FAMIXCPPMethod >> sourceAnchor [
	^ super sourceAnchor
		ifNil: [ (implementation notNil
				ifTrue: [ implementation sourceAnchor ])
				ifNil: [ declaration notNil
						ifTrue: [ declaration sourceAnchor ] ] ]
]
