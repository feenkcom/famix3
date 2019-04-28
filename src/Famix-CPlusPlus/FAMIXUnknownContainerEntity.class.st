Class {
	#name : #FAMIXUnknownContainerEntity,
	#superclass : #FAMIXContainerEntity,
	#instVars : [
		'belongsTo'
	],
	#category : #'Famix-CPlusPlus'
}

{ #category : #meta }
FAMIXUnknownContainerEntity class >> annotation [
	<MSEClass: #UnknownContainerEntity super: #FAMIXContainerEntity>
	<package: #FAMIX>
]

{ #category : #accessing }
FAMIXUnknownContainerEntity >> belongsTo [
	<MSEProperty: #belongsTo type: #FAMIXContainerEntity>
	<MSEComment: 'Parent entity of this unknown'>
	<container>
	^ belongsTo
]

{ #category : #accessing }
FAMIXUnknownContainerEntity >> belongsTo: anObject [
	belongsTo := anObject
]
