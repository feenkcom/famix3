"
An association to represent a pointer to a behavioural in C/C++ (i.e. ""&f()"")
"
Class {
	#name : #FAMIXBehaviouralReference,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'referer',
		'pointed'
	],
	#category : #'Famix-CPlusPlus'
}

{ #category : #meta }
FAMIXBehaviouralReference class >> annotation [
	<MSEClass: #BehaviouralReference super: #FAMIXAssociation>
	<package: #FAMIX>
]

{ #category : #visiting }
FAMIXBehaviouralReference >> accept: aVisitor [

	aVisitor visitAccess: self
]

{ #category : #accessing }
FAMIXBehaviouralReference >> from [

	^ self referer 
]

{ #category : #accessing }
FAMIXBehaviouralReference >> pointed [
	<MSEProperty: #pointed type: #FAMIXBehaviouralEntity opposite: #references>
	<MSEComment: 'BehaviouralEntity refered to. to-side of the association'>
	<target>
	^ pointed
]

{ #category : #accessing }
FAMIXBehaviouralReference >> pointed: aBehaviouralEntity [
	pointed := FMMultivalueLink on: self
					update: #references
					from: self pointed
					to: aBehaviouralEntity
]

{ #category : #printing }
FAMIXBehaviouralReference >> printOn: aStream [
	self referer name ifNotNil: [ aStream nextPutAll: self referer name ].
	aStream nextPutAll: ' -> &('.
	self pointed name ifNil: ['?'] ifNotNil: [ aStream nextPutAll: self pointed name ].
	aStream nextPutAll: ')'
]

{ #category : #accessing }
FAMIXBehaviouralReference >> referer [
	<MSEProperty: #referer type: #FAMIXBehaviouralEntity opposite: #behaviouralPointers>
	<MSEComment: 'Behavioural entity pointing to the behavioural entity. from-side of the association'>
	<source>
	^ referer
]

{ #category : #accessing }
FAMIXBehaviouralReference >> referer: aBehaviouralEntity [ 
	referer := FMMultivalueLink 
		on: self
		update: #behaviouralPointers
		from: self referer
		to: aBehaviouralEntity
]

{ #category : #accessing }
FAMIXBehaviouralReference >> to [
	^ self pointed 
]
