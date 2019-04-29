Extension { #name : #String }

{ #category : #'*Famix-Core' }
String >> asFAMIXComment [
	^ FAMIXComment content: self
]

{ #category : #'*Famix-Core' }
String >> famixRemovePrefix: prefix [
	"Remove the given prefix, if present."

	^(self beginsWith: prefix) ifTrue: [ self copyFrom: 1 + prefix size to: self size ] ifFalse: [ self ]
]

{ #category : #'*Famix-Core' }
String >> famixRemoveSuffix: suffix [
	"Remove the given suffix, if present."

	^(self endsWith: suffix) ifTrue: [ self copyFrom: 1 to: self size - suffix size ] ifFalse: [ self ]
]
