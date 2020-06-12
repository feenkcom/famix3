Class {
	#name : #GtPhpSymfonyServiceReference,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'source',
		'target'
	],
	#category : #'Famix-PHP-Symfony'
}

{ #category : #accessing }
GtPhpSymfonyServiceReference >> from [
	^ self source
]

{ #category : #accessing }
GtPhpSymfonyServiceReference >> source [
	<MSEProperty: #source type: #FAMIXType>
	^ source
]

{ #category : #accessing }
GtPhpSymfonyServiceReference >> source: anObject [
	source := anObject
]

{ #category : #accessing }
GtPhpSymfonyServiceReference >> target [
	^ target
]

{ #category : #accessing }
GtPhpSymfonyServiceReference >> target: anObject [
	target := anObject
]

{ #category : #accessing }
GtPhpSymfonyServiceReference >> to [
	^ self target
]
