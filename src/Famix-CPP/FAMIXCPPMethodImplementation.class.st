Class {
	#name : #FAMIXCPPMethodImplementation,
	#superclass : #FAMIXSourcedEntity,
	#instVars : [
		'method'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXCPPMethodImplementation >> method [
	<MSEProperty: #method type: #FAMIXCPPMethod opposite: #implementation>
	^ method
]

{ #category : #accessing }
FAMIXCPPMethodImplementation >> method: aCPPMethod [
	method := aCPPMethod
]

{ #category : #printing }
FAMIXCPPMethodImplementation >> mooseNameOn: stream [
	method mooseNameOn: stream.
	stream nextPutAll: ' implmementation'
]

{ #category : #accessing }
FAMIXCPPMethodImplementation >> name [
	^ method name , ' implementation'
]
