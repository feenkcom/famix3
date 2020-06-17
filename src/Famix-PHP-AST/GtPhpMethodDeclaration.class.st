Class {
	#name : #GtPhpMethodDeclaration,
	#superclass : #GtPhpBodyDeclaration,
	#traits : 'TGtPhpMethodDeclaration',
	#classTraits : 'TGtPhpMethodDeclaration classTrait',
	#instVars : [
		'comment',
		'functionDeclaration'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpMethodDeclaration >> children [
	| result |
	result := super children.
	functionDeclaration ifNotNil: [ :x | result add: x ].
	comment ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpMethodDeclaration >> comment [
	^ comment
]

{ #category : #accessing }
GtPhpMethodDeclaration >> function [
	^ functionDeclaration
]
