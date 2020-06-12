Class {
	#name : #GtPhpSymfonyService,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'arguments',
		'implementationClass'
	],
	#category : #'Famix-PHP-Symfony'
}

{ #category : #accessing }
GtPhpSymfonyService >> addArgument: anArgument [
	self arguments add: anArgument
]

{ #category : #accessing }
GtPhpSymfonyService >> arguments [
	^ arguments
]

{ #category : #accessing }
GtPhpSymfonyService >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtPhpSymfonyService >> implementationClass [
	^ implementationClass
]

{ #category : #accessing }
GtPhpSymfonyService >> implementationClass: aClass [
	implementationClass := aClass.
	aClass ifNotNil: [ aClass phpSymfonyService: self ]
]

{ #category : #initialization }
GtPhpSymfonyService >> initialize [
	super initialize.
	arguments := OrderedCollection new
]
