Class {
	#name : #FAMIXAbstractFileReferenceAnchor,
	#superclass : #FAMIXAbstractFileAnchor,
	#instVars : [
		'fileName'
	],
	#category : #'Famix-SourceAnchor'
}

{ #category : #accessing }
FAMIXAbstractFileReferenceAnchor >> fileName [
	<MSEProperty: #fileName type: #String>
	<MSEComment: 'Name of the source file'>
	^ fileName
]

{ #category : #accessing }
FAMIXAbstractFileReferenceAnchor >> fileName: aFileName [
	fileName := aFileName copyReplaceAll: '\' with: '/'. 
]
