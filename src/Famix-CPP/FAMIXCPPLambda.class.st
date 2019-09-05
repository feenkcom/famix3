Class {
	#name : #FAMIXCPPLambda,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'outerMethod'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXCPPLambda >> outerMethod [
	<MSEProperty: #outerMethod type: #FAMIXCPPMethod opposite: #lambdas>
	<derived>
	^ outerMethod
]

{ #category : #accessing }
FAMIXCPPLambda >> outerMethod: aMethod [
	outerMethod := FMMultivalueLink
		on: self
		update: #lambdas
		from: self outerMethod
		to: aMethod
]
