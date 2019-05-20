Class {
	#name : #FAMIXCPPMethodDeclaration,
	#superclass : #FAMIXSourcedEntity,
	#instVars : [
		'method'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXCPPMethodDeclaration >> method [
	<MSEProperty: #method type: #FAMIXCPPMethod opposite: #declaration>
	^ method
]

{ #category : #accessing }
FAMIXCPPMethodDeclaration >> method: aCPPMethod [
	method := aCPPMethod
]

{ #category : #printing }
FAMIXCPPMethodDeclaration >> mooseNameOn: stream [
	method mooseNameOn: stream.
	stream nextPutAll: ' declaration'
]

{ #category : #accessing }
FAMIXCPPMethodDeclaration >> name [
	^ method name , ' declaration'
]
