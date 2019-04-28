Class {
	#name : #FAMIXUnknownBehaviouralEntity,
	#superclass : #FAMIXBehaviouralEntity,
	#instVars : [
		'belongsTo'
	],
	#category : #'Famix-CPlusPlus'
}

{ #category : #meta }
FAMIXUnknownBehaviouralEntity class >> annotation [
	<MSEClass: #UnknownBehaviouralEntity super: #FAMIXBehaviouralEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
FAMIXUnknownBehaviouralEntity >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXContainerEntity>
	<MSEComment: 'Parent entity of this unknown'>
	<container>
	^ belongsTo
]

{ #category : #accessing }
FAMIXUnknownBehaviouralEntity >> belongsTo: anObject [
	belongsTo := anObject
]
