Class {
	#name : #GtPhpSymfonyServiceArgument,
	#superclass : #GtPhpSymfonyArgument,
	#instVars : [
		'service'
	],
	#category : #'Famix-PHP-Symfony'
}

{ #category : #accessing }
GtPhpSymfonyServiceArgument >> service [
	^ service
]

{ #category : #accessing }
GtPhpSymfonyServiceArgument >> service: aService [
	service := aService
]
