Class {
	#name : #FAMIXClassChefTest,
	#superclass : #TestCase,
	#category : #'Famix-Tests-Core'
}

{ #category : #tests }
FAMIXClassChefTest >> testDefaultClassScope [
	| class |
	class := FAMIXClass new.
	self assert: class typeScope == class
]

{ #category : #tests }
FAMIXClassChefTest >> testNilNamespaceScope [
	self assert: FAMIXClass new namespaceScope isNil
]
