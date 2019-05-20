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
FAMIXCPPMethod >> sourceAnchor [
	^ super sourceAnchor
		ifNil: [ (implementation notNil
				ifTrue: [ implementation sourceAnchor ])
				ifNil: [ declaration notNil
						ifTrue: [ declaration sourceAnchor ] ] ]
]
