Class {
	#name : #FAMIXAbstractFileReferenceAnchor,
	#superclass : #FAMIXAbstractFileAnchor,
	#instVars : [
		'fileName'
	],
	#category : #'Famix-SourceAnchor'
}

{ #category : #meta }
FAMIXAbstractFileReferenceAnchor class >> annotation [
	<MSEClass: #AbstractFileReferenceAnchor super: #FAMIXAbstractFileAnchor>
	<package: #FAMIX>
]

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
